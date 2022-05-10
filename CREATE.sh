SHELL=/bin/bash

package_name=$1
repo_name=$2
py_version=$3
license=$4

echo $package_name
echo $repo_name
echo $py_version
echo $license

# mkdir $package_name

set -u  # exit if undefined variable being referenced

replace_placeholders(){
    PLACEHOLDER=$1
    REPLACEMENT=$2

    LC_ALL=C find ./ -type f -exec sed -i '' -e "s/{$PLACEHOLDER}/$REPLACEMENT/g" {} \;
}

replace_placeholders package_name $package_name
replace_placeholders repo_name $repo_name
replace_placeholders py_version $py_version
replace_placeholders license $license

# rm -rf .git
# git init
# git remote add origin "https://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@github.com/w2sv/$repo_name"

# rm CREATE.sh
# mv ../python-package-template ../$repo_name
