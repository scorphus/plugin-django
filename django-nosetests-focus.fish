function django-nosetests-focus -a verbosity -d "Run nosetests focused tests"
  django-tests-cleanup
  env REUSE_DB="1" coverage run tests/testproject/manage.py test tests/ \
    --settings=testproject.settings_test_focus \
    --with-yanc --yanc-color=yes --ipdb --ipdb-failures $verbosity
end
