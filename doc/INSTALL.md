- [Requirements](#requirements)
- [Howto build the SonarQube ecoCode plugins](#howto-build-the-sonarqube-ecocode-plugins)
  - [Requirements](#requirements-1)
  - [Build the code](#build-the-code)
- [Howto install SonarQube dev environment](#howto-install-sonarqube-dev-environment)
  - [Requirements](#requirements-2)
  - [Start SonarQube (if first time)](#start-sonarqube-if-first-time)
  - [Reinstall SonarQube (if needed)](#reinstall-sonarqube-if-needed)
  - [Configuration SonarQube](#configuration-sonarqube)
- [Howto install Plugin](#howto-install-plugin)
- [Howto start or stop service (already installed)](#howto-start-or-stop-service-already-installed)
- [Howto create a release](#howto-create-a-release)
- [Howto debug a rule (with logs)](#howto-debug-a-rule-with-logs)

Requirements
------------

- Docker
- Docker-compose

Howto build the SonarQube ecoCode plugins
-----------------------------------------

### Requirements

- Java >= 11.0.17
- Mvn 3
- SonarQube 9.4 to 9.9

### Build the code

You can build the project code by running the following command in the `src` directory.
Maven will download the required dependencies.

```sh
./tool_build.sh
```

Each plugin is generated in its own `<plugin>/target` directory, but they are also copied to the `lib` directory.

Howto install SonarQube dev environment
---------------------------------------

### Requirements

You must have built the plugins (see the steps above).

### Start SonarQube (if first time)

Run the SonarQube + PostgreSQL stack:

```sh
./tool_docker-init.sh
```

Check if the containers are up:

```sh
docker ps
```

You should see two lines (one for sonarqube and one for postgres).
If there is only postgres, check the logs:

```sh
./tool_docker-logs.sh
```

If you have this error on run:
`web_1 | [1]: max virtual memory areas vm.max_map_count [65530] is too low, increase to at least [262144]`
you can allocate more virtual memory:

```sh
sudo sysctl -w vm.max_map_count=262144
```

For Windows:

```sh
wsl -d docker-desktop
sysctl -w vm.max_map_count=262144
```

Go to http://localhost:9000 and use these credentials:

```txt
login: admin
password: admin
```

When you are connected, generate a new token:

`My Account -> Security -> Generate Tokens`

![img.png](resources/img.png)
![img_1.png](resources/img_1.png)

Start again your services using the token:

```sh
TOKEN=MY_TOKEN docker-compose up --build -d
```

### Reinstall SonarQube (if needed)

```sh
# first clean all containers and resources used
./tool_docker-clean.sh

# then, install from scratch de SonarQube containers and resources
./tool_docker-init.sh
```

### Configuration SonarQube
*Purposes* : Configure SonarQube to have all ecocode plugins rules enabled by default.

Check plugins installation :

- go to your SonarQube homepage `http://localhost:9000/`
- the first time after initialization, you are suggested to change `admin` password
- check plugins installation :
  - go to "Adminitration" tab
  - go to "Marketplace" sub-tab
  - go bottom, and clic on "Installed" sub-tab
  - check here, if you have ecoCode plugins displayed with a SNAPSHOT version

Create a new profile with Ecocode plugins rules :

- go to "Quality Profiles" tab
- choose your language to create a new profile - ex : `java`
- click on menu at the end of "Sonar Way" line for this language
- choose "extend" (or "copy" if you prefer)
- give a name to new profile (ex : "MyProfileName"), then click on "extend" (or "copy") button
- in the new page (profile page), click on "Activate more" button (to add new rules)
- in the new page (rule page), in the left menu, choose "Tag" menu and write "eco" word in search field
- click on `eco-conception` choice displayed below : all rules with that tag are displayed to the right
- click on "Bulk Change" button and choose "Activate in MyProfileName", then "Apply"

Make the new profile as default for your language :

- go to "Quality Profiles" tab
- click on menu at the end of line of your new profile
- choose "set as Default"

After these 2 steps, all code source for your language will be analyzed with your new Profile (and its activated plugins rules).

Howto install Plugin
--------------------

Install dependencies from the root directory:

```sh
./tool_build.sh
```

Result : JAR files (one per plugin) will be copied in `lib` repository after build.

Howto start or stop service (already installed)
-----------------------------------------------

Once you did the installation a first time (and then you did custom configuration like quality gates, quality
profiles, ...),
if you only want to start (or stop properly) existing services :

```sh
./tool_start.sh
./tool_stop.sh
```

Howto create a release
----------------------

1. IF the new release wanted is a major or minor version (`X` or `Y` in `X.Y.Z`)
   1. THEN modify the old version to the new version in all XML files (with a find/replace)
   2. ELSE the new corrective version (`Z` in `X.Y.Z`) will be automatic
2. add release notes in `CHANGELOG.md` file for next release
    1. Replace `Unreleased` title with the new version like `Release X.Y.Z` and the date
        1. ... where `X.Y.Z` is the new release
        2. ... follow others examples
        3. ... clean content of current release changelog (delete empty sub-sections)
        4. respect [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) format
    2. add above an empty `Unreleased` section with sub-sections (`Added`, `Changed` and `Deleted`)
    3. add a new section in the list at the bottom of file with new version
    4. update `docker-compose.yml` with next SNAPSHOT corrective version
    5. commit these modifications
3. if all is ok, execute `tool_release_1_prepare.sh` to prepare locally the next release and next SNAPSHOT (creation of 2 new commits and a tag) and check these commits and tag
4. if all is ok, execute `tool_release_2_branch.sh` to create and push a new branch with that release and SNAPSHOT
5. if all is ok, on github, create a PR based on this new branch to `main` branch
6. wait that automatic check (Github `Actions` tab) on the new branch are OK, then check modifications and finally merge it with `Create a merge commit` option
7. if PR merge is OK, then delete the branch as mentionned when PR merged
8. wait that automatic check on the `main` branch are OK, and then if all is ok, upgrade your local source code from remote, and go to `main` branch
9. push new tag with `git push --tags`
10. an automatic workflow started on github and create the new release of plugin

Howto debug a rule (with logs)
------------------------------

1. Add logs like in [OptimizeReadFileExceptions](https://github.com/green-code-initiative/ecoCode/blob/main/java-plugin/src/main/java/fr/greencodeinitiative/java/checks/OptimizeReadFileExceptions.java) class file
2. Build plugin JARs with `tool_build.sh`
3. Launch local Sonar with `tool_docker_init.sh`
4. Launch a sonar scanner on an exemple project with `mvn verify` command (only the first time), followed
   by `mvn org.sonarsource.scanner.maven:sonar-maven-plugin:3.9.1.2184:sonar -Dsonar.login=***** -Dsonar.password=***** -X`
5. logs will appear in console (debug logs will appear if `-X` option is given like above)
