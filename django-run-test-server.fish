function django-run-test-server -d 'Run Django on a test project'
  django-kill-test-server
  clean-pycs
  env PYTHONPATH="$PYTHONPATH:." python -u tests/testproject/manage.py \
    runserver 0.0.0.0:8000 --settings=testproject.settings_IGNOREME
end
