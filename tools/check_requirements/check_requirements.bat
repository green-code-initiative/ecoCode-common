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

echo "***** Checking MAVEN -->"
mvn --version
if %ERRORLEVEL% == 0 (
  echo " - installation [ OK ]"
) else (
  echo " - installation [ NON OK ] : please check or install tool"
)

echo "***** Checking GIT -->"
git --version
if %ERRORLEVEL% == 0 (
  echo " - installation [ OK ]"
) else (
  echo " - installation [ NON OK ] : please check or install tool"
)