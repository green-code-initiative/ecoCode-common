#!/bin/bash

. _config.sh

###########################################################################################
#    C O R E     ( /!\ /!\ /!\ NOT to modify)
###########################################################################################
MAGENTA='\033[38;5;201m'
PINK='\033[38;5;219m'
BLUE='\033[38;5;39m'
GREY='\033[38;5;235m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

### display debug logs if DEBUG enabled
### $1 : message to log
debug() {
  if [ $DEBUG == 1 ]; then
    echo -e "${GREY}--- DEBUG --- $1${NC}"
  fi
}

### launch requirements checks
### $1 : the command to check
### $2 : the command label to display in messages
function check_requirement() {

  declare -a command="$1"
  declare -a label="$2"

  debug "*****  Checking $label installation  *****"
  debug "command for check = \"$command --version 2>/dev/null 1>/dev/null; echo \$?\""
  declare -a res=`$command --version 2>/dev/null 1>/dev/null; echo $?`
  if [ $res == 0 ]; then
    echo -e "Checking $label installation ... [ ${GREEN}OK${NC} ]"
  else
    echo -e "Checking $label installation ... [ ${RED}NON OK${NC} ] : please ${PINK}check or install $label${NC}"
  fi

}

### launch requirements checks (command, min version and max version)
### $1 : the command to check
### $2 : the command label to display in messages
### $3 : the minimum version to check
### $4 : the maximum version to check
function check_requirement_with_version() {

  declare -a command="$1"
  declare -a libelle="$2"
  declare -a version_min="$3"
  declare -a version_max="$4"

  check_requirement "$1" "$2"

  debug "*****  Checking $libelle MIN version ('$version_min')  *****"
  debug "command for check = \"$command --version 2>/dev/null 1>/dev/null; echo \$?\""
  declare -a res=`$command --version 2>/dev/null 1>/dev/null; echo $?`
  if [ $res == 0 ]; then
    echo -e "Checking $libelle min version ('$version_min') ... [ ${GREEN}OK${NC} ]"
  else
    echo -e "Checking $libelle min version ('$version_min') ... [ ${RED}NON OK${NC} ] : please ${PINK}check or install $libelle${NC}"
  fi

}
