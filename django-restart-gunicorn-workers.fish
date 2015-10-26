function django-restart-gunicorn-workers -d "Restart ALL Gunicorn workers"
  set pycode "
from signal import SIGHUP

import psutil


def restart():
  processes = {}
  parent_pids = []
  sighup_procs = set()
  for proc in psutil.process_iter():
    try:
      pinfo = proc.as_dict(attrs=['name', 'cmdline'])
    except psutil.NoSuchProcess:
      pass
    else:
      if pinfo['name'].startswith('python'):
        if pinfo['cmdline'] and len(pinfo['cmdline']) > 1 \
           and pinfo['cmdline'][1].endswith('gunicorn'):
          if proc.pid in parent_pids:
            print('Found the master itself: %s (%d)' % (
              proc.name(), proc.pid
            ))
            sighup_procs.add(proc)
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
              print('Found a worker’s master: %s (%d)' % (
                pnt_name, pnt_pid
              ))
              sighup_procs.add(processes[pnt_pid])
            parent_pids.append(pnt_pid)
            processes[proc.pid] = proc

  if not processes:
    print('Nothing to do')
  elif len(processes) == 1:
    pid, proc = processes.popitem()
    print('There is only one left: %d' % pid)
    sighup_procs = set([proc] + list(sighup_procs))
  else:
    print('Restarting %d masters...' % len(sighup_procs))
    for proc in sighup_procs:
      proc.send_signal(SIGHUP)


if __name__ == '__main__':
  restart()
"
  python -c $pycode
end