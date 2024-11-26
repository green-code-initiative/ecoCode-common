#!/bin/bash

. _core.sh

debug "JAVA_VERSION_MIN : $JAVA_VERSION_MIN"
debug "JAVA_VERSION_MAX : $JAVA_VERSION_MAX"
debug "JAVA_CLASS_VERSION_MIN : $JAVA_CLASS_VERSION_MIN"
debug "JAVA_CLASS_VERSION_MAX : $JAVA_CLASS_VERSION_MAX"
debug "MAVEN_VERSION_MIN : $MAVEN_VERSION_MIN"
debug "MAVEN_VERSION_MAX : $MAVEN_VERSION_MAX"

echo -e "***** Docker 🚀"
check_installation "docker --version"

echo -e "***** Docker-compose 🚀"
check_installation "docker-compose --version"

echo -e "***** Java 🚀"
check_installation "javap -version"

class_version=`javap -verbose java.lang.String | grep "major version" | cut -d " " -f5`
check_version_min_java "$class_version" "$JAVA_CLASS_VERSION_MIN" "$JAVA_VERSION_MIN"
check_version_max_java "$class_version" "$JAVA_CLASS_VERSION_MAX" "$JAVA_VERSION_MAX"

echo -e "***** Maven 🚀"
check_installation "mvn --version"

mvn_version=`mvn --version 2>&1 | head -1 | cut -d " " -f3`
check_version_min_maven "$mvn_version" "$MAVEN_VERSION_MIN"
check_version_max_maven "$mvn_version" "$MAVEN_VERSION_MAX"

echo -e "***** Git 🚀"
check_installation "git --version"

echo -e "***** jq 🚀"
check_installation "jq --version"

