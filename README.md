![](https://img.shields.io/badge/license-MIT-007EC7.svg?style=flat-square)

<div align="center">
    <a href="http://github.com/oh-my-fish/oh-my-fish">
        <img width="90" src="https://cloud.githubusercontent.com/assets/8317250/8510172/f006f0a4-230f-11e5-98b6-5c2e3c87088f.png">
    </a>
</div><br>


## django

Collection of Fish functions to aid Django web development. The following
functions are included:

- `django-run-test-server`: Run Django on a test project
- `django-run-test-server-no-reload`: Same as above, with no reload
- `django-kill-test-server`: Kill the aforementioned instance
- `django-run-gunicorn`: Run Django with Gunicorn (see function description)
- `django-restart-memcached`: Restart memcached on port `10007`
- `django-signal-gunicorn-workers`: Send SIGNAL to all Gunicorn masters
- `django-tests-cleanup`: Clean pycs, reset installed_test
- `django-nosetests-unit`: Run nosetests unit tests
- `django-nosetests-unit-v`: Run nosetests unit tests verbosely
- `django-nosetests-focus`: Run nosetests focused tests
- `django-nosetests-focus-v`: Run nosetests focused tests verbosely
- `django-nosetests-focus-ignore`: Run nosetests ignoring focus-ignored tests
- `django-nosetests-focus-ignore-v`: Run nosetests ignoring focus-ignored tests verbosely


### Install

```fish
$ omf install https://github.com/scorphus/plugin-django
```


## License

[MIT](http://opensource.org/licenses/MIT) © [scorphus](https://github.com/scorphus)
