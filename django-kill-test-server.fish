function django-kill-test-server -a p
  set argn (count $argv)
  test $argn -ge 1; and test $p -ge 1024; or set p 8000
  set pids (ps ax | grep $p | grep python | awk '{print $1}')
  test "$pids" != ""; and kill $pids; or return 0
end
