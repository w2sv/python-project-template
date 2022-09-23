SHELL=/bin/bash

help(){
 echo
}

while getopts "r:p:v:l:d:h" opt
do
   case "$opt" in
      r ) repo="$OPTARG" ;;
      p ) package="$OPTARG" ;;
      v ) version="$OPTARG";;
#          re='^[0-9]+$'
#          ((version =~ $re)) || help ;;
      l ) license="$OPTARG" ;;
      d ) description="$OPTARG" ;;
      h ) help ;;
      * ) echo "Received unknown argument"; exit 2;;
#      ? ) helpFunction ;; # Print helpFunction in case parameter is non-existent
   esac
done

if [ -z "$repo" ] || [ -z "$version" ] || [ -z "$license" ]; then
    echo "Missing arguments"
    exit 2
fi

if [ -z "$package" ]; then
  package="$repo"
fi

replace_placeholders(){
    PLACEHOLDER=$1
    REPLACEMENT=$2

    echo "Insert $REPLACEMENT"

    LC_ALL=C find . -type f ! -name 'CREATE.sh' -exec sed -i '' -e "s/$PLACEHOLDER/$REPLACEMENT/g" {} \; > /dev/null 2>&1
}

# replace placeholders
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

# make src dir with __init__
echo "Make $package dir with __init__.py"
mkdir "$package"
touch "$package/__init__.py"

# echo "Remove CREATE.sh"
#rm CREATE.sh

# echo "Rename root dir"
#mv ../python-package-template ../"$repo_name"
