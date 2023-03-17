@echo off

echo "***** Checking DOCKER -->"
docker --version
if %ERRORLEVEL% == 0 (
  echo " - installation [ OK ]"
) else (
  echo " - installation [ NON OK ] : please check or install tool"
)

echo "***** Checking DOCKER-COMPOSE -->"
docker-compose --version
if %ERRORLEVEL% == 0 (
  echo " - installation [ OK ]"
) else (
  echo " - installation [ NON OK ] : please check or install tool"
)

echo "***** Checking JAVA -->"
java -version
if %ERRORLEVEL% == 0 (
  echo " - installation [ OK ]"
) else (
  echo " - installation [ NON OK ] : please check or install tool"
)
echo "===> please check version : 11 <= JDK version <= 17"

echo "***** Checking MAVEN -->"
mvn --version
if %ERRORLEVEL% == 0 (
  echo " - installation [ OK ]"
) else (
  echo " - installation [ NON OK ] : please check or install tool"
)
echo "===> please check version : 3.5.2 <= MAVEN version <= 3.9.0"

echo "***** Checking GIT -->"
git --version
if %ERRORLEVEL% == 0 (
  echo " - installation [ OK ]"
) else (
  echo " - installation [ NON OK ] : please check or install tool"
)