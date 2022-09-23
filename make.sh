SHELL=/bin/bash

help(){
 echo "Script Options:
  -r: repository name
  -p: package name (optional, will be set to repository name if unspecified)
  -v: python version
  -l: license
  -d: repository/package description (optional)
  -h: show this help text"
  exit 2
}

# parse options
while getopts "r:p:v:l:d:h" opt
do
   case "$opt" in
      r ) repo="$OPTARG" ;;
      p ) package="$OPTARG" ;;
      v ) version="$OPTARG" ;;
      l ) license="$OPTARG" ;;
      d ) description="$OPTARG" ;;
      h ) help ;;
      * ) echo "Received unknown argument."; echo; help ;;
#      ? ) helpFunction ;; # Print helpFunction in case parameter is non-existent
   esac
done

# exit if required options not passed
if [ -z "$repo" ] || [ -z "$version" ] || [ -z "$license" ]; then
    echo "Arguments missing."; echo; help
fi

# equate package and repo variables if package not passed
if [ -z "$package" ]; then
  package="$repo"
fi

# remove template README.md
rm README.md

# replace placeholders
replace_placeholders(){
    PLACEHOLDER=$1
    REPLACEMENT=$2

    echo "Insert $REPLACEMENT"

    LC_ALL=C find . -type f ! -name 'CREATE.sh' -exec sed -i '' -e "s/$PLACEHOLDER/$REPLACEMENT/g" {} \; > /dev/null 2>&1
}

replace_placeholders "{PACKAGE_NAME}" "$package"
replace_placeholders "{REPO_NAME}" "$repo"
replace_placeholders "{PY_VERSION}" "$version"
replace_placeholders "{LICENSE}" "$license"

if [ -z "$description" ]; then
  replace_placeholders "{DESCRIPTION}" "$description"
fi

# do git-related modifications
username=$(git config user.name)

replace_placeholders "{EMAIL}" "$(git config user.email)"
replace_placeholders "{USER}" "$username"

url="https://github.com/$username/$repo"
echo "Set git remote url to $url"
git remote set-url origin "$url"

# everything else
echo "Make $package dir with __init__.py"
mkdir "$package"
touch "$package/__init__.py"

echo "Set README.md"
mv readme_template.md README.md

echo "Remove CREATE.sh"
rm make.sh

echo "Rename root dir"
mv ../python-project-template ../"$repo"

# remove old dir if persisted
rm -rf python-project-template/
