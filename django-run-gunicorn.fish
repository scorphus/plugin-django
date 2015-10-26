function django-run-gunicorn -a p -a w -a l -a t \
    -d "Run Django with Gunicorn ([port] [workers] [level] [timeout])"

  contains -- "--help" $argv; or contains -- "-h" $argv; and begin
    echo "Usage: django-run-gunicorn [port] [workers] [level] [timeout]"
    return 0
  end

  set log_levels "debug" "info" "warning" "error" "critical"
  set argn (count $argv)
  test $argn -ge 1; and test $p -ge 1024; or set p 8000           # port
  test $argn -ge 2; and test $w -ge 1; or set w 2                 # workers
  test $argn -ge 3; and contains "$l" $log_levels; or set l info  # level
  test $argn -ge 4; and test $t -ge 60; or set t 600              # timeout
  django-kill-test-server $p
  printf "Running Gunicorn with %02d worker%s on $p with $l and %s\n" $w (
    test $w -gt 1; and echo "s"
  ) $t
  env PYTHONPATH="$PYTHONPATH:.:tests/testproject/" \
    DJANGO_SETTINGS_MODULE="testproject.settings_IGNOREME" \
    gunicorn --log-level $l -w $w -t $t -b 0.0.0.0:$p \
    testproject.wsgi
end
