# Install notes - EcoCode

- [Global Requirements](#global-requirements)
- [HOWTO build the SonarQube ecoCode plugins](#howto-build-the-sonarqube-ecocode-plugins)
  - [Requirements](#requirements)
  - [Build the code](#build-the-code)
- [HOWTO install SonarQube dev environment](#howto-install-sonarqube-dev-environment)
  - [Requirements](#requirements-1)
  - [Start SonarQube (if first time)](#start-sonarqube-if-first-time)
  - [Configuration SonarQube](#configuration-sonarqube)
    - [Change password](#change-password)
    - [Check plugins installation](#check-plugins-installation)
    - [Generate access token](#generate-access-token)
    - [Initialize default profiles for `ecocode` plugins](#initialize-default-profiles-for-ecocode-plugins)
- [HOWTO reinstall SonarQube (if needed)](#howto-reinstall-sonarqube-if-needed)
- [HOWTO start or stop service (already installed)](#howto-start-or-stop-service-already-installed)
- [HOWTO install new plugin version](#howto-install-new-plugin-version)
- [HOWTO debug a rule (with logs)](#howto-debug-a-rule-with-logs)
- [HOWTO create a release (core-contributor rights needed)](#howto-create-a-release-core-contributor-rights-needed)
- [HOWTO publish new release on SonarQube Marketplace](#howto-publish-new-release-on-sonarqube-marketplace)
  - [New release from scratch](#new-release-from-scratch)
  - [New release of existing plugin](#new-release-of-existing-plugin)
- [HOWTO publish a new version of ecocode-rules-specifications on Maven Central](#howto-publish-a-new-version-of-ecocode-rules-specifications-on-maven-central)
  - [Requirements](#requirements-2)
  - [Maven Central publish process](#maven-central-publish-process)
- [HOWTO configure publish process on Maven Central (core-contributor rights needed)](#howto-configure-publish-process-on-maven-central-core-contributor-rights-needed)
  - [Update OSSRH token](#update-ossrh-token)
    - [What is OSSRH token ?](#what-is-ossrh-token-)
    - [Why change these variables ?](#why-change-these-variables-)
    - [How to generate new values and update Github Secrets ?](#how-to-generate-new-values-and-update-github-secrets-)
  - [Update GPG Maven Central keys](#update-gpg-maven-central-keys)
    - [What is GPG Maven Central keys ?](#what-is-gpg-maven-central-keys-)
    - [How to install and use GPG command line tool ?](#how-to-install-and-use-gpg-command-line-tool-)
    - [Why change these variables ?](#why-change-these-variables--1)
    - [How to generate new values and update Github Secrets ?](#how-to-generate-new-values-and-update-github-secrets--1)

## Global Requirements

- Docker
- Docker-compose

## HOWTO build the SonarQube ecoCode plugins

### Requirements

- Java >= 11.0.17
- Mvn 3
- SonarQube 9.4 to 9.9

### Build the code

You can build the project code by running the following command in the root directory.
Maven will download the required dependencies.

```sh
./tool_build.sh
```

Each plugin is generated in its own `<plugin>/target` directory, but they are also copied to the `lib` directory.

## HOWTO install SonarQube dev environment

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

Result example :
![Result example](resources/docker-ps-result.png)

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

### Configuration SonarQube

*Purposes* : Configure SonarQube to have all ecocode plugins rules enabled by default.

#### Change password

- go to your SonarQube homepage `http://localhost:9000/`
- use default credentials : `admin`/ `admin`
- the first time after first connexion, you are suggested to change `admin` password

#### Check plugins installation

- go to "Adminitration" tab
- go to "Marketplace" sub-tab
- go bottom, and clic on "Installed" sub-tab
- check here, if you have ecoCode plugins displayed with a SNAPSHOT version

#### Generate access token

When you are connected, generate a new token on `My Account -> Security -> Generate Tokens`

![Administrator menu](resources/adm-menu.png)
![Security tab](resources/security-tab.png)

Instead of login+password authentication, this token can now be used as value for `sonar.login` variable when needed (examples : call sonar scanner to send metrics to SonarQube, on use internal tools, ...)

#### Initialize default profiles for `ecocode` plugins

- use tool `install_profile.sh` in `ecocode-common` repository (inside directory `tools/rules_config`)
  - if you want, you can check default configuration of this tool in `_config.sh` file
- launch followed command : `./install_profile.sh <MY_SONAR_TOKEN>`

After this step, all code source for your language will be analyzed with your new Profile (and its activated plugins rules).

## HOWTO reinstall SonarQube (if needed)

```sh
# first clean all containers and resources used
./tool_docker-clean.sh

# then, build plugins (if not already done)
./tool_build.sh

# then, install from scratch de SonarQube containers and resources
./tool_docker-init.sh
```

## HOWTO start or stop service (already installed)

Once you did the installation a first time (and then you did custom configuration like quality gates, quality
profiles, ...),
if you only want to start (or stop properly) existing services :

```sh

# start WITH previously created token (to do : change the token inside script)
./tool_start_withtoken.sh

# start without previously created token
./tool_start.sh

# stop the service
./tool_stop.sh
```

## HOWTO install new plugin version

1. Install dependencies from the root directory:

```sh
./tool_build.sh
```

Result : JAR files (one per plugin) will be copied in `lib` repository after build.

2. Restart SonarQube

```sh
# stop the service
./tool_stop.sh

# start the service
./tool_start.sh
```

## HOWTO debug a rule (with logs)

1. Add logs like in [OptimizeReadFileExceptions](https://github.com/green-code-initiative/ecoCode/blob/main/java-plugin/src/main/java/fr/greencodeinitiative/java/checks/OptimizeReadFileExceptions.java) class file
2. Build plugin JARs with `tool_build.sh`
3. Launch local Sonar with `tool_docker_init.sh`
4. Launch a sonar scanner on an exemple project with `mvn verify` command (only the first time), followed
   by :
   - if token created : `mvn org.sonarsource.scanner.maven:sonar-maven-plugin:3.9.1.2184:sonar -Dsonar.login=MY_TOKEN -X`
   - if login and password : `mvn org.sonarsource.scanner.maven:sonar-maven-plugin:3.9.1.2184:sonar -Dsonar.login=MY_LOGIN -Dsonar.password=MY_PASSWORD -X`
5. logs will appear in console (debug logs will appear if `-X` option is given like above)

## HOWTO create a release (core-contributor rights needed)

1. IF **new release wanted** is a **major** or **minor** version (`X` or `Y` in `X.Y.Z`)
   1. **THEN** **modify the old version** to the new version in **all XML/YML files**
   2. **ELSE** **no modification** needed : the new corrective version (`Z` in `X.Y.Z`) will be automatic
2. **upgrade `CHANGELOG.md`** : add release notes for next release
    1. **Replace `Unreleased` title** with the new version like `Release X.Y.Z` and the date
        1. ... where `X.Y.Z` is the new release
        2. ... follow others examples
        3. ... clean content of current release changelog (delete empty sub-sections)
        4. respect [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) format
    2. **add above an empty `Unreleased`** section with sub-sections (`Added`, `Changed` and `Deleted`)
    3. **add a new section in the list at the bottom** of file with new version
    4. **commit** these modifications
3. prepare locally next release and next snapshot :
   1. **execute `tool_release_1_prepare.sh`** script to prepare locally the next release and next SNAPSHOT (creation of 2 new commits and a tag)
   2. **check locally** these 2 commits and tag
4. create and push new local branch : 
   1. **execute `tool_release_2_branch.sh`** to create and push a new branch with that release and SNAPSHOT
   2. **check on github** that this new branch is created and pushed
5. create new github PR :
   1. on github, **create a new PR** based on this new branch to `main` branch
   2. **check Action** launch and result for this new PR
6. merge PR
   1. **merge PR** on `main` branch with `Create a merge commit` option
   2. **check Action** launch and result on `main` branch
7. push new tag created previously :
   1. locally, **go to and update `main`** branch
   2. **execute `git push --tags`** to push new previously created tag
   3. **check Action** launch and result on new tag
8. **upgrade `docker-compose.yml`** file (if exists) with new SNAPSHOT version

## HOWTO publish new release on SonarQube Marketplace

### New release from scratch

1. Create a fork of [SonarSource/sonar-update-center-properties](https://github.com/SonarSource/sonar-update-center-properties.git)
2. Change corresponding plugin metadata file (for `ecocode-java`: [ecocodejava.properties](https://github.com/SonarSource/sonar-update-center-properties/blob/master/ecocodejava.properties), for `ecocode-php`: [ecocodephp.properties](https://github.com/SonarSource/sonar-update-center-properties/blob/master/ecocodephp.properties), for `ecocode-python`: [ecocodepython.properties](https://github.com/SonarSource/sonar-update-center-properties/blob/master/ecocodepython.properties)): 
   - Append new version to `publicVersions` value (comma separated value)
   - Add following properties (where `X.X.X` is new release to publish):
     - `X.X.X.description`: a summary of main changes for user for this version
     - `X.X.X.sqVersions`: supported range version of SonarQube
     - `X.X.X.date`: Release date of plugin (on GitHub Release page)
     - `X.X.X.downloadUrl`: link to doanwload this specific release
     - `X.X.X.changelogUrl`: link to detailed change log of this release
3. Create a Pull-Request for those modifications on [SonarSource/sonar-update-center-properties](https://github.com/SonarSource/sonar-update-center-properties/pulls) to annonce new release of the corresponding plugin, with:
   - a summary of main changes for user
   - the download link
   - the link to detailed release note
   - the link to SonarCloud corresponding project

Additional information:

- [check description of previous merged Pull-Requests](https://github.com/SonarSource/sonar-update-center-properties/pulls?q=is%3Apr+is%3Amerged)
- [github.com - SonarSource/sonar-update-center-properties](https://github.com/SonarSource/sonar-update-center-properties)
- [sonar community - Deploying to the Marketplace](https://community.sonarsource.com/t/deploying-to-the-marketplace/35236)
- documentation : [README.md](https://github.com/SonarSource/sonar-update-center-properties/blob/master/README.md)

Examples :

- [PR example 1](https://github.com/SonarSource/sonar-update-center-properties/pull/389)
- [PR example 2](https://github.com/SonarSource/sonar-update-center-properties/pull/409)

### New release of existing plugin

... quite like "New release from scratch" section above but ...

- process : [SonarSource documentation - new release](https://community.sonarsource.com/t/deploying-to-the-marketplace/35236#announcing-new-releases-2)
- documentation : [README.md](https://github.com/SonarSource/sonar-update-center-properties/blob/master/README.md)
- example : [PR example](https://github.com/SonarSource/sonar-update-center-properties/pull/468)

## HOWTO publish a new version of ecocode-rules-specifications on Maven Central

### Requirements

You need write rights to use Maven Central publish process (mainteners or core-team members).

**Create a new release of `ecoCode` repository** : please see above [HOWTO create a release](#howto-create-a-release-core-contributor-rights-needed).

Why create a new release before ?
Because publish process of `ecocode-rules-specifications` on Maven Central needs a tag on `ecoCode` repository.

### Maven Central publish process

- go to "Action" tab of `ecoCode` reposiroty
- click on "Publish to Maven Central" workflow
- click on "Run workflow" list button
- choose a tag version (and not a branch because SNAPSHOT version won't be published on Maven Central)
- click on "Run workflow" button
- check launched workflow on Actions tab
- 20 minutes later (because of Maven central internal process), check on maven central if new version is published

## HOWTO configure publish process on Maven Central (core-contributor rights needed)

### Update OSSRH token

#### What is OSSRH token ?

`OSSRH_TOKEN` and `OSSRH_USERNAME` are used for communication between Github and Sonatype Nexus system for publish process to Maven Central.
Nexus URL : https://s01.oss.sonatype.org/

These variables are stored in Github Secrets available `Settings` tab of `ecoCode` repository, in `Secrets and variables` sub-tab, in `Actions` sub-section.

#### Why change these variables ?

Values are get from a specific Sonatype Nexus account.

Actually, `ecoCode` Sonatype Nexus account was used to generate values corresponding to `OSSRH_TOKEN` and `OSSRH_USERNAME` variables.

If we want use another account, we need to change these values by generating new ones on this new account.

#### How to generate new values and update Github Secrets ?

1. Go to [Sonatype Nexus](https://oss.sonatype.org/)
2. Login with account (ex : `ecoCode`)
3. Go to `Profile` tab
4. Go to `User Token` sub-tab present in top list (`Summary` value is selected by default)
5. Click on `Access User Token` button
6. New values will be generated and displayed
7. Copy these values and paste them in Github Secrets in `ecoCode` repository, respectively in `OSSRH_TOKEN` variable (the password) and `OSSRH_USERNAME` variable (the username)
8. Check publish process with a new release version (see above [HOWTO configure publish process on Maven Central](#howto-configure-publish-process-on-maven-central))

### Update GPG Maven Central keys

#### What is GPG Maven Central keys ?

GPG system is used to sign JAR files before publishing them to Maven Central.
We have to generate public and private keys, and store them in Github Secrets with `MAVEN_GPG_PRIVATE_KEY` and `MAVEN_GPG_PASSPHRASE` variables.

These GPG keys are stored in Github Secrets available `Settings` tab of `ecoCode` repository, in `Secrets and variables` sub-tab, in `Actions` sub-section.

Values are generated on local machine with "gpg" command line tool.

#### How to install and use GPG command line tool ?

on MAC OS (for the moment) :

- `brew install gpg` to install tool
- `gpg --version` to check version of GPG tool
- `gpg --gen-key` to generate private and public keys : WARNING, you need to remember passphrase used to generate keys
- `gpg --list-keys` to list keys (and display expiration date)
- `gpg --keyserver keyserver.ubuntu.com --send-keys <MY_PUBLIC_KEY>` to send public key to one fo web key servers : MANDATORY to publish on Maven Central
- `gpg --keyserver keyserver.ubuntu.com --recv-keys <MY_PUBLIC_KEY>` to get public key from keyserver : TO check if our public key is ok and known by keyserver
- `gpg --output private.pgp --armor --export-secret-key "<MY_PUBLIC_KEY>"` to export private key to a local file

For information, version of GPG command line tool :
```sh
❯❯❯ gpg --version

gpg (GnuPG) 2.4.3
libgcrypt 1.10.2
Copyright (C) 2023 g10 Code GmbH
License GNU GPL-3.0-or-later <https://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Home: <MY_HOME>/.gnupg
Algorithmes pris en charge :
Clef publique : RSA, ELG, DSA, ECDH, ECDSA, EDDSA
Chiffrement : IDEA, 3DES, CAST5, BLOWFISH, AES, AES192, AES256,
              TWOFISH, CAMELLIA128, CAMELLIA192, CAMELLIA256
Hachage : SHA1, RIPEMD160, SHA256, SHA384, SHA512, SHA224
Compression : Non compressé, ZIP, ZLIB, BZIP2
```

#### Why change these variables ?

We can check expiration date with `gpg --list-keys` command.
Current keys are valid until **2026-08-07**.
If we want to upgrade these keys, we need to generate new ones and reconfigure Github Secrets.

#### How to generate new values and update Github Secrets ?

1. Generate new keys with `gpg --gen-key` command : we need to give a passphrase (you can give old one)
2. Send public key to keyserver with `gpg --keyserver keyserver.ubuntu.com --send-keys <MY_PUBLIC_KEY>` command
3. Check and get public key from keyserver with `gpg --keyserver keyserver.ubuntu.com --recv-keys <MY_PUBLIC_KEY>` command
4. Export private key to a local `private.pgp` file with `gpg --output private.pgp --armor --export-secret-key "<MY_PUBLIC_KEY>"`
5. Open this local file and copy content (only content between `-----BEGIN PGP PRIVATE KEY BLOCK-----` and `-----END PGP PRIVATE KEY BLOCK-----` included)
6. Paste this content in `MAVEN_GPG_PRIVATE_KEY` variable in Github Secrets
7. If you changed the passphrase in first step, paste it in `MAVEN_GPG_PASSPHRASE` variable in Github Secrets
8. Check publish process with a new release version (see above [HOWTO configure publish process on Maven Central](#howto-configure-publish-process-on-maven-central))
