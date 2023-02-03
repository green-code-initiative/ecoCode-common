#!/bin/bash

. _core.sh

# Docker version
# debug "DOCKER_VERSION_MIN : $DOCKER_VERSION_MIN"
# debug "DOCKER_VERSION_MAX : $DOCKER_VERSION_MAX"
# debug "DOCKERCOMPOSE_VERSION_MIN : $DOCKERCOMPOSE_VERSION_MIN"
# debug "DOCKERCOMPOSE_VERSION_MAX : $DOCKERCOMPOSE_VERSION_MAX"
debug "JAVA_VERSION_MIN : $JAVA_VERSION_MIN"
debug "JAVA_VERSION_MAX : $JAVA_VERSION_MAX"
debug "MAVEN_VERSION_MIN : $MAVEN_VERSION_MIN"
debug "MAVEN_VERSION_MAX : $MAVEN_VERSION_MAX"
# debug "GIT_VERSION_MIN : $GIT_VERSION_MIN"
# debug "GIT_VERSION_MAX : $GIT_VERSION_MAX"

check_requirement "docker" "Docker"
check_requirement "docker-compose" "Docker-compose"
check_requirement_with_version "java" "Java" "$JAVA_VERSION_MIN" "$JAVA_VERSION_MAX"
check_requirement_with_version "mvn" "Maven" "$MAVEN_VERSION_MIN" "$MAVEN_VERSION_MAX"
check_requirement "git" "Git"
