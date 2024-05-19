# Starter Pack to develop on EcoCode

- [Starter Pack to develop on EcoCode](#starter-pack-to-develop-on-ecocode)
  - [Basic Explanations](#basic-explanations)
    - [Sonarqube Plugin](#sonarqube-plugin)
      - [How a SonarQube plugin works](#how-a-sonarqube-plugin-works)
    - [Gitflow](#gitflow)
    - [Github Green-Code-Initiative](#github-green-code-initiative)
    - [Some rules references](#some-rules-references)
      - [115 web rules details](#115-web-rules-details)
      - [40+ android/iOS rules details](#40-androidios-rules-details)
  - [Local development](#local-development)
    - [Requirements](#requirements)
      - [Method 1 - Automatic check (default method)](#method-1---automatic-check-default-method)
      - [Method 2 - Manual check (if above "method 1" doesn't work)](#method-2---manual-check-if-above-method-1-doesnt-work)
    - [Get source code](#get-source-code)
    - [Start local environment](#start-local-environment)
    - [Choose the rule you want to implement](#choose-the-rule-you-want-to-implement)
    - [Test your rule implementation](#test-your-rule-implementation)
  - [Publish your work](#publish-your-work)
    - [Check the completion of your work : Definition Of Done](#check-the-completion-of-your-work--definition-of-done)
    - [Commit your code](#commit-your-code)
    - [Open pull request](#open-pull-request)
    - [Review others development](#review-others-development)
    - [Validation of a PR](#validation-of-a-pr)
    - [Close your rule](#close-your-rule)
  - [Different development processes](#different-development-processes)
    - [Deprecation of existing rule](#deprecation-of-existing-rule)
      - [STEP 1 : deprecate rule](#step-1--deprecate-rule)
      - [STEP 2 : remove rule](#step-2--remove-rule)

## Basic Explanations

In order to develop a Sonarqube Plugin in Open source for ecocode, two basics must have been understood :

- How to develop a Sonarqube plugin
- Understand and work with the Gitflow

### Sonarqube Plugin

Here is official documentation to understand how to develop a sonar plugin : <https://docs.sonarqube.org/latest/extend/developing-plugin/>
But ... we are going to help you more specifically for `ecoCode` project in following sections.

#### How a SonarQube plugin works

Code is parsed to be transformed as AST. AST will allow you to access one or more nodes of your code.
For example, you’ll be able to access of all your `for` loop, to explore content etc.

To better understand AST structure, you can use the [AST Explorer](https://astexplorer.net/).

JavaScript plugin works differently because it does not use AST. [More information here](javascript-plugin/README.md)

### Gitflow

What is GtiFlow and how it works : <https://medium.com/android-news/gitflow-with-github-c675aa4f606a>

### Github Green-Code-Initiative

- common part (doc / tools) : <https://github.com/green-code-initiative/ecoCode-common>
- rules specification : <https://github.com/green-code-initiative/ecoCode>
- several mobile repositories
- several standard repositories
- several test project repositories

### Some rules references

#### 115 web rules details

<https://github.com/cnumr/best-practices>

#### 40+ android/iOS rules details

<https://github.com/cnumr/best-practices-mobile>

## Local development

This section is to help you to install and configure your first environment to develop with us !!!

### Requirements

#### Method 1 - Automatic check (default method)

In the current repository, go to `tools/check_requirements` directory.
Next, execute script verification () :

For Mac or Unix OS : `./check_requirements.sh`

For Windows OS :

- execute script : `./check_requirements.bat`
- then check versions displayed

PS : if you have some problems with this script, please feel free to create a new issue here <https://github.com/green-code-initiative/ecoCode-common/issues>

#### Method 2 - Manual check (if above "method 1" doesn't work)

- `Docker` : <https://docs.docker.com/get-docker/>
- `Docker-compose` : <https://docs.docker.com/compose/install/>
- `Java` JDK (and not only JRE) for Sonarqube plugin Development : <https://www.java.com/fr/download/manual.jsp>
- `Maven` for Sonarqube plugin Development : <https://maven.apache.org/download.cgi>
- `Git` : <https://git-scm.com/book/en/v2/Getting-Started-Installing-Git>

If you want, you can check following file to know what are min and max versions for each tool : <https://github.com/green-code-initiative/ecoCode-common/blob/main/tools/check_requirements/config.txt>

Then launch check commands as follows (and check versions displayed) :

```sh
docker --version
docker-compose --version
javap -version
mvn --version
git --version
```

### Get source code

Clone the project with (standard, mobile or/and common) : please see all availables repositories here <https://github.com/orgs/green-code-initiative/repositories?type=all>

Example for Java plugin (with SSH) :
```sh
git clone git@github.com:green-code-initiative/ecoCode-java.git
```

### Start local environment

You will find all steps to start and configure your local Sonarqube dev Environment here :

- 1st step - build your local plugin: <https://github.com/green-code-initiative/ecoCode-common/blob/main/doc/INSTALL.md#howto-build-the-sonarqube-ecocode-plugins>
- 2nd step - launch local Sonarqube (with installation of previous local plugin built) : <https://github.com/green-code-initiative/ecoCode-common/blob/main/doc/INSTALL.md#howto-install-sonarqube-dev-environment>
- 3rd step - check that local environment is running perfectly : choose one of repositories with suffix "test-project" (ex : <https://github.com/green-code-initiative/ecoCode-java-test-project/tree/main>)
  - next, launch script `tool_send_to_sonar.sh` (using previous secruitty token created on the first step)
  - finally, open local SonarQube GUI (<http://localhost:9000>) to verify if alone project raises ecoCode errors

### Choose the rule you want to implement

Once your local environment is running, you can pick a rule waiting to be implemented : <https://github.com/green-code-initiative/ecoCode/blob/main/RULES.md#rules-support-matrix-by-techno>

### Test your rule implementation

Each rule needs to have scripts in a specific language (i.e. Python, Rust, JS, PHP and JAVA) in order to test directly inside Sonarqube that the rule has been implemented.

To validate that the rule has been implemented, you need to execute a scan on those scripts. You will need sonar scanner: <https://docs.sonarqube.org/latest/analysis/scan/sonarscanner/>

## Publish your work

### Check the completion of your work : Definition Of Done

To have the best PR, we strongly recommend you to follow this check-list :

- [ ] Check if rule doesn't exist in SonarQube yet
- [ ] Implement rule
- [ ] Add documentation and code tags on the rule, along with triggering and non triggering examples
- [ ] Write Unit tests (triggering and non triggering cases)
- [ ] Update RULES.md
- [ ] Update `CHANGELOG.md` file (inside `Unreleased` section)
- [ ] Create PR on the real test project to add a triggering case
- [ ] Create PR on the `ecocode` repository to add the new rule definition (`ecocode-rules-specifications`)
- [ ] Fix potential SonarCloud issues / out-of-date warnings

### Commit your code

Create a new branch following this pattern : <rule_id>-<language>
Example :

```sh
git checkout -b 47-JS
```

Commit your code :

```sh
git add .
git commit -m "your comments"
```

Push your branch :

```sh
git push origin <rule_id>-<language>
```

You may have to log with your account : <https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token>

### Open pull request

Once your code is pushed and tested, open a PR between your branch and "main" : <https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request>

### Review others development

Ask to people to review your PR. Once two people, at least, have reviewed, you can validate your PR
If you want to be reviewed, review others... It's a win/win situation

### Validation of a PR

Validate your PR or ask to someone who have the permissions to validate your PR.
Once PR validated, a github workflow is automatically launched. Thus, the new implemented code is also scan with our internal Sonar to check the implemented code quality.
Here is the SonarQube : <https://sonarcloud.io/organizations/green-code-initiative/projects>

### Close your rule

Once your PR is validated, your rule integrates ecoCode. In <https://github.com/cnumr/ecoCode/projects/1>, move it from the "In Progress" column to the "Done" column.
Well done.

## Different development processes

### Deprecation of existing rule

If you want to deprecate an existing rule, you have to follow 2 steps as described below.

#### STEP 1 : deprecate rule

This step is done on next release of plugin (example : version N).

1. Upgrade the rule implementation to add deprecation information : in plugin repository containing the rule implementation, add a new `@DeprecatedRule` annotation on the rule class
2. Upgrade rules documentation
   1. in plugin repository containing the rule implementation, in `RULES.md` file, move rule line from standard rules array to deprecated rules array
   2. in `ecoCode-rules-specification` repository, add deprecation to current rule

Thus in next release of plugin, the rule will be still present but displayed as deprecated in SonarQube UI.

#### STEP 2 : remove rule

This step is done on release N+2.

1. Clean implementation code of the rule :
   1. in plugin repository containing the rule implementation
      1. delete rule class, clean all references to the rule
      2. delete unit test classes
   2. in plugin real test project repository, clean rule test classes
2. Upgrade rules documentation : in plugin repository containing the rule implementation, in `RULES.md` file, mark the rule as deleted
