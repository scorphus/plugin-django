function django-tests-cleanup -d "Clean pycs, reset installed_test"
  clean-pycs
  rmf tests/testproject/components/installed_test
  mkdirp tests/testproject/components/installed_test
end
