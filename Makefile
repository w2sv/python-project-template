SHELL=/bin/bash

# $$$$$$$$ Testing $$$$$$$$$

test: mypy pytest doctest coverage-report

mypy:
	mypy /{PACKAGE_NAME}

pytest:
	coverage run -m pytest -vv tests/

doctest:
	coverage run -am pytest -vv --doctest-modules --doctest-continue-on-failure ./{PACKAGE_NAME}/

coverage-report:
	coverage xml
	coverage report

coverage-show-html:
	coverage html
	open htmlcov/index.html