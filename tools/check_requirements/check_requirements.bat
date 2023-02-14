REM == Define CodeNarc version
REM set codenarc_version=2.2.3
set JAVA_VERSION_MIN=11
set JAVA_CLASS_VERSION_MIN=55
set JAVA_VERSION_MAX=17
set JAVA_CLASS_VERSION_MAX=61
set MAVEN_VERSION_MIN=3.5.2
set MAVEN_VERSION_MAX=3.8.7

echo "***** Checking Docker -->"
REM declare "-a" "command="%~1""
REM declare "-a" "res=%undefined%"

docker --version > nul
if %ERRORLEVEL% == 0 (
  echo " - installation [ %GREEN%OK%NC% ]"
) else (
  echo " - installation [ %RED%NON OK%NC% ] : please %PINK%check or install tool%NC%"
)

REM == Build CodeNarc
REM cd codenarc-converter/CodeNarc
REM call ./gradlew build -x test

REM == Deploy to local repository
REM mvn -B install:install-file -Dfile=build/libs/CodeNarc-%codenarc_version%.jar -DgroupId=org.codenarc -DartifactId=CodeNarc -Dversion=%codenarc_version% -Dpackaging=jar
