function django-nosetests-unit -a verbosity -d "Run nosetests unit tests"
  django-tests-cleanup
  env REUSE_DB "1" coverage run tests/testproject/manage.py test tests/ \
    --settings=testproject.settings_test --with-yanc --yanc-color=yes $verbosity
  if test $status -eq 0
    coverage report -m --fail-under=65
  end
end
