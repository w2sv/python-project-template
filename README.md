# __Python project template__

Just another template to set up a python repository (whether to become a pypi package or not) for usage with poetry, mypy, pytest, doctest, coverage, github actions & codecov, as well as with README badges!!! 🤯 

## Usage
```shell
$ git clone https://github.com/w2sv/python-package-template.git
$ cd python-package-template
$ make.sh \
    -r repo_name \
    -p package_name  # optional, will be set to repo_name if not specified \
    -v python_version  # e.g. 3.10
    -l license
    -d description # optional
    -h  # show help text
```

After that all the template-specific files such as this README.md will be removed, the parent directory renamed & the git remote url set, such that you'll only have to define your dependencies in the pyproject.toml, install the environment, add a license text to LICENSE and you're all set to get to the actual coding part.     
