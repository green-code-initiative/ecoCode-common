#!/bin/bash

###########################################################################################
#    C O R E     ( /!\ /!\ /!\ NOT to modify)
###########################################################################################
MAGENTA='\033[38;5;201m'
PINK='\033[38;5;219m'
BLUE='\033[38;5;39m'
GREY='\033[38;5;240m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Import configurations from config.txt
while IFS="=" read -r key value || [ -n "$key" ]; do
    # Remove inline comments and trim whitespace
    key=$(echo "$key" | sed 's/\s*#.*//')
    value=$(echo "$value" | sed 's/\s*#.*//')

    # Skip empty lines
    if [[ -z $key ]]; then
        continue
    fi

    declare "$key=$value"
done < config.txt

### display debug logs if DEBUG enabled
### $1 : message to log
debug() {
  if [[ $DEBUG == 1 ]]; then
    echo -e "${GREY}--- DEBUG --- $1${NC}"
  fi
}

### launch requirements checks
### $1 : the command to check
function check_installation() {

  declare -a command="$1"

  declare -a res=`$command 2>/dev/null 1>/dev/null; echo $?`
  if [[ $res == 0 ]]; then
    echo -e "   ✅ installation"
  else
    echo -e "   ❌ installation : please ${PINK}check or install tool${NC}"
  fi
  debug "command for check = \"$command 2>/dev/null 1>/dev/null; echo \$?\""

}

### launch requirements checks (command and min version)
### $1 : java class version to check
### $2 : the minimum java class version
### $3 : the minimum java version
function check_version_min_java() {

  declare -a version_class=$1
  declare -a version_class_min=$2
  declare -a version_jdk_min=$3

  if [[ "$version_class_min" -le "$version_class" ]]; then
    echo -e "   ✅ min version"
  else
    echo -e "   ❌ min version : please ${PINK}check or install good version ${NC}"
  fi

  echo -e "        (current class version : $version_class)"
  echo -e "        (min class version : '$JAVA_CLASS_VERSION_MIN' / min jdk version : '$JAVA_VERSION_MIN')"

}

### launch requirements checks (command and max version)
### $1 : java class version to check
### $2 : the maximum java class version
### $3 : the maximum java version
function check_version_max_java() {

  declare -a version_class=$1
  declare -a version_class_max=$2
  declare -a version_jdk_max=$3

  if [[ "$version_class" -le "$version_class_max" ]]; then
    echo -e "   ✅ max version"
  else
    echo -e "   ❌ max version : please ${PINK}check or install good version ${NC}"
  fi

  echo -e "        (current class version : $version_class)"
  echo -e "        (max class version : '$JAVA_CLASS_VERSION_MAX' / max jdk version : '$JAVA_VERSION_MAX')"

}

### launch requirements checks (command and min version)
### $1 : the current version
### $2 : the minimum version to check
function check_version_min_maven() {

  declare -a version="$1"
  declare -a version_min="$2"

  if [[ "$version_min" < "$version" || "$version_min" = "$version" ]]; then
    echo -e "   ✅ min version"
  else
    echo -e "   ❌ min version : please ${PINK}check or install good version ${NC}"
  fi

  echo -e "        (current version : $version / min version : '$version_min')"

}

### launch requirements checks (command and max version)
### $1 : the current version
### $2 : the maximum version to check
function check_version_max_maven() {

  declare -a version="$1"
  declare -a version_max="$2"

  if [[ "$version" < "$version_max" || "$version" = "$version_max" ]]; then
    echo -e "   ✅ max version"
  else
    echo -e "   ❌ max version : please ${PINK}check or install good version ${NC}"
  fi

  echo -e "        (current version : $version / max version : '$version_max')"

}
