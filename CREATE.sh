SHELL=/bin/bash

# exit script in case of insufficient number of arguments received
if [ "$#" -ne 4 ]; then
    echo "Illegal number of parameters; Required 4, received $#" >&2
    exit 2
fi

package_name=$1
repo_name=$2
py_version=$3
license=$4

# replace placeholders
replace_placeholders(){
    PLACEHOLDER=$1
    REPLACEMENT=$2

    echo replacing $PLACEHOLDER with $REPLACEMENT

    LC_ALL=C find ./ -type f -exec sed -i '' -e "s/$PLACEHOLDER/$REPLACEMENT/g" {} \; > /dev/null 2>&1
}

replace_placeholders {PACKAGE_NAME} $package_name
replace_placeholders {REPO_NAME} $repo_name
replace_placeholders {PY_VERSION} $py_version
replace_placeholders {LICENSE} $license

# make src dir
mkdir $package_name

# remove .git corresponding to template repo and initialize new one
rm -rf .git
git init
git remote add origin "https://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@github.com/w2sv/$repo_name"

# remove CREATE script and rename parent directory
rm CREATE.sh
mv ../python-package-template ../$repo_name