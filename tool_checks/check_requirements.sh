#!/bin/bash

. _core.sh

# Docker version
# debug "DOCKER_VERSION_MIN : $DOCKER_VERSION_MIN"
# debug "DOCKER_VERSION_MAX : $DOCKER_VERSION_MAX"
# debug "DOCKERCOMPOSE_VERSION_MIN : $DOCKERCOMPOSE_VERSION_MIN"
# debug "DOCKERCOMPOSE_VERSION_MAX : $DOCKERCOMPOSE_VERSION_MAX"
debug "JAVA_VERSION_MIN : $JAVA_VERSION_MIN"
debug "JAVA_VERSION_MAX : $JAVA_VERSION_MAX"
debug "JAVA_CLASS_VERSION_MIN : $JAVA_CLASS_VERSION_MIN"
debug "JAVA_CLASS_VERSION_MAX : $JAVA_CLASS_VERSION_MAX"
debug "MAVEN_VERSION_MIN : $MAVEN_VERSION_MIN"
debug "MAVEN_VERSION_MAX : $MAVEN_VERSION_MAX"
# debug "GIT_VERSION_MIN : $GIT_VERSION_MIN"
# debug "GIT_VERSION_MAX : $GIT_VERSION_MAX"

echo -e "***** Checking Docker -->"
check_installation "docker --version"

echo -e "***** Checking Docker-compose -->"
check_installation "docker-compose --version"

echo -e "***** Checking Java -->"
check_installation "javap -version"

#cmd_java_version="java -version 2>&1 | head -1 | cut -d'\"' -f2 | sed '/^1\./s///' | cut -d'.' -f1"
class_version=`javap -verbose java.lang.String | grep "major version" | cut -d " " -f5`
check_version_min_java "$class_version" "$JAVA_CLASS_VERSION_MIN" "$JAVA_VERSION_MIN"
check_version_max_java "$class_version" "$JAVA_CLASS_VERSION_MAX" "$JAVA_VERSION_MAX"

echo -e "***** Checking Maven -->"
check_installation "mvn --version"

mvn_version=`mvn --version 2>&1 | head -1 | cut -d " " -f3`
check_version_min_maven "$mvn_version" "$MAVEN_VERSION_MIN"
check_version_max_maven "$mvn_version" "$MAVEN_VERSION_MAX"

echo -e "***** Checking Git -->"
check_installation "git --version"
