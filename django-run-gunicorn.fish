function django-run-gunicorn -a p -a w -a l -a t \
    -d "Run Django with Gunicorn ([port] [workers] [level] [timeout] [OPTIONS])"

  contains -- "--help" $argv; or contains -- "-h" $argv; and begin
    echo "Usage: django-run-gunicorn [port] [workers] [level] [timeout] [OPTIONS]"
    return 0
  end

  set log_levels "debug" "info" "warning" "error" "critical"
  set argn (count $argv)
  test $argn -ge 1; and test $p -ge 1024; or set p 8000              # port
  test $argn -ge 2; and test $w -ge 1; or set w 2                    # workers
  test $argn -ge 3; and contains -- "$l" $log_levels; or set l info  # level
  test $argn -ge 4; and test $t -ge 60; or set t 600                 # timeout
  test $argn -ge 5; and set o $argv[5..-1]                           # options

  printf "Running with %02d worker%s on $p, $l-logging, timing out with %ss\n" \
    $w (test $w -gt 1; and echo "s"; or echo "") $t

  [ -n "$o" ]; and printf "Additional options: %s\n" (echo $o)

  ps ax | grep 10007 | grep memcached > /dev/null
  or echo "WARNING: memcached not running!"

  [ -z (printenv PYTHONPATH) ]
    and set -x PYTHONPATH "$PYTHONPATH:.:tests/testproject/"
  [ -z (printenv DJANGO_SETTINGS_MODULE) ]
    and set -x DJANGO_SETTINGS_MODULE "testproject.settings_IGNOREME"
  [ -z (printenv WSGI_APP) ]
    and set -x WSGI_APP "testproject.wsgi"

  django-kill-test-server $p
  gunicorn $o --log-level $l -w $w -t $t -b 0.0.0.0:$p $WSGI_APP

end
