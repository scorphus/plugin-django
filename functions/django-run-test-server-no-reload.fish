function django-run-test-server-no-reload -d "run-test-server, with no reload"
  django-kill-test-server
  clean-pycs
  env PYTHONPATH="$PYTHONPATH:." python -u tests/testproject/manage.py \
    runserver 0.0.0.0:8000 --settings=testproject.settings_IGNOREME --noreload
end
