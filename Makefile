SHELL=/bin/bash

###########
# Testing #
###########

test: mypy pytest doctest coverage-report  # run with -k flag in order to continue in case of recipe failure

mypy:
	mypy package_name/

pytest:
	coverage run -m pytest -vv tests/

doctest:
	python -m pytest -vv --doctest-modules --doctest-continue-on-failure ./package_name/

coverage-report:
	coverage xml
	coverage report

##############
# Publishing #
##############

publish: test patch-version _publish

patch-version:
	poetry version patch

_publish:
	poetry publish --build