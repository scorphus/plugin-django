function django-restart-memcached -d "Restart memcached on port 10007"
  set pids (ps ax | grep 10007 | grep memcached | awk '{print $1}')
  test "$pids" -ne ""
    and echo "Restarting memcached..."
      and kill $pids
    or echo "Running memcached..."
  memcached -v -p 10007 >/dev/null 2>&1 &
end
