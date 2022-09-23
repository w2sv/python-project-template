SHELL=/bin/bash

# exit script in case of insufficient number of arguments received
#if [ "$#" -ne 4 ]; then
#    echo "Illegal number of parameters; Required 4, received $#" >&2
#    exit 2
#fi

while getopts "r:p:v:l" opt
do
   case "$opt" in
      r ) repo="$OPTARG" ;;
      p ) package="$OPTARG" ;;
      v ) version="$OPTARG" ;;
      l ) license="$OPTARG" ;;
      * ) echo "Received unknown argument"; exit 2;;
#      ? ) helpFunction ;; # Print helpFunction in case parameter is non-existent
   esac
done

# replace placeholders
replace_placeholders(){
    PLACEHOLDER=$1
    REPLACEMENT=$2

    echo "Replacing $PLACEHOLDER with $REPLACEMENT"

    LC_ALL=C find ./ -type f -exec sed -i '' -e "s/$PLACEHOLDER/$REPLACEMENT/g" {} \; > /dev/null 2>&1
}

replace_placeholders "{PACKAGE_NAME}" "$package"
replace_placeholders "{REPO_NAME}" "$repo"
replace_placeholders "{PY_VERSION}" "$version"
replace_placeholders "{LICENSE}" "$license"

# make src dir with __init__
mkdir "$package"
touch "$package/__init__.py"

## remove .git corresponding to template repo and initialize new one
#rm -rf .git
#git init
#git remote add origin "https://github.com/w2sv/$repo_name"
#
## remove CREATE script and rename parent directory
#rm CREATE.sh
#mv ../python-package-template ../"$repo_name"
