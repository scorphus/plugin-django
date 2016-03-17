function django-list-gunicorn-masters -d "List Gunicorn masters"

  set pycode "
# -*- coding: utf-8 -*-

import psutil


def list():
  processes = {}
  parent_pids = []
  master_procs = set()
  for proc in psutil.process_iter():
    try:
      pinfo = proc.as_dict(attrs=['name', 'cmdline'])
    except psutil.NoSuchProcess:
      pass
    else:
      if 'python' in pinfo['name'] or 'gunicorn' in pinfo['name']:
        if pinfo['cmdline'] and len(pinfo['cmdline']) > 1 \
            and 'gunicorn' in pinfo['cmdline'][1]:
          if proc.pid in parent_pids:
            print('Found the master itself: %s (%d)' % (
              proc.name(), proc.pid
            ))
            master_procs.add(proc)
            processes[proc.pid] = proc
            continue
          try:
            pnt_pid = proc.parent().pid
            pnt_name = proc.parent().name()
          except TypeError:
            pnt_pid = proc.parent.pid
            pnt_name = proc.parent.name()
          finally:
            if pnt_pid in processes and pnt_pid not in parent_pids:
              print(u'Found a worker’s master: %s (%d)' % (
                pnt_name, pnt_pid
              ))
              master_procs.add(processes[pnt_pid])
            parent_pids.append(pnt_pid)
            processes[proc.pid] = proc

  if not processes:
    print('Nothing to list')
    return

  if len(processes) == 1:
    proc = processes.popitem()
    master_procs = set([proc] + list(master_procs))

  print('Listing {} master(s)...\n'.format(len(master_procs)))
  for proc in master_procs:
    print('  PID: {}\n  Name: {}\n  CmdLine: {}\n  Parent: {}, ({})\n'.format(
      proc.pid,
      proc.name(),
      ' '.join(proc.cmdline()),
      proc.parent().name(),
      proc.parent().pid,
    ))


if __name__ == '__main__':
  list()
"
  python -c $pycode
end
