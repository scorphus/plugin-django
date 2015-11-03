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
    set lines ""
    for _ in (seq (math (tput lines) - $num_of_lines - 1))
      set lines "$lines\n"
    end
    set date (date +"%x %X")
    set max_cols (math (tput cols) - 10)
    echo -ne $proc_list | awk $awk_cmd | cut -c 1-$max_cols | sort -n | pipeset p_list
    echo -ne $lines$date" - Watching Gunicorn processes every "$s"s:\n"$p_list
    sleep $s
  end
end
