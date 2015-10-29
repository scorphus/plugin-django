function django-watch-gunicorn-procs -a s -d "Watch running Gunicorn processes"

  contains -- "--help" $argv; or contains -- "-h" $argv; and begin
    echo "Usage: django-watch-gunicorn-procs [period-in-seconds]"
    return 0
  end

  test (count $argv) -eq 1; or set s 2
  while true
    set awk_cmd '{print $3 "\t" $2 "\t" $5 "\t" $7 "\t" $8 " " $9}'
    ps -efaxw | grep python | grep gunicorn | grep -v grep | pipeset proc_list
    set num_of_lines (echo $proc_list | wc -l)
    for _ in (seq (math (tput lines) - $num_of_lines - 1))
      echo
    end
    echo (date +"%x %X") "- Watching Gunicorn processes every "$s"s:"
    echo -ne $proc_list | awk $awk_cmd | cut -c 1-(math (tput cols) - 10)
    sleep $s
  end
end
