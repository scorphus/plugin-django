function django-nosetests-focus-ignore -a verbosity -d "Run nosetests ignoring focus-ignored tests"
  django-tests-cleanup
  env REUSE_DB="1" coverage run tests/testproject/manage.py test tests/ \
    --settings=testproject.settings_test_focus_ignore \
    --with-yanc --yanc-color=yes $verbosity
end
