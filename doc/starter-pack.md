# Starter Pack to develop on EcoCode

- [Starter Pack to develop on EcoCode](#starter-pack-to-develop-on-ecocode)
  - [Basics](#basics)
    - [Sonarqube Plugin](#sonarqube-plugin)
      - [How a SonarQube plugin works](#how-a-sonarqube-plugin-works)
    - [Gitflow](#gitflow)
    - [Github GreenCodeInitiative](#github-greencodeinitiative)
    - [References](#references)
      - [115 web rules details](#115-web-rules-details)
      - [40+ android/iOS rules details](#40-androidios-rules-details)
  - [Local development](#local-development)
    - [Requirements](#requirements)
      - [Method 1 - Automatic check](#method-1---automatic-check)
      - [Method 2 - Manual check](#method-2---manual-check)
    - [Clone the project](#clone-the-project)
    - [Start local environment](#start-local-environment)
    - [Choose your rule](#choose-your-rule)
    - [Test your development](#test-your-development)
  - [Publish your work](#publish-your-work)
    - [Commit your code](#commit-your-code)
    - [Open pull request](#open-pull-request)
      - [Definition Of Done of a PR](#definition-of-done-of-a-pr)
    - [Review others development](#review-others-development)
    - [Validation of a PR](#validation-of-a-pr)
    - [Close your rule](#close-your-rule)
  - [Development Processes](#development-processes)
    - [Deprecation of existing rule](#deprecation-of-existing-rule)
      - [STEP 1 : deprecate rule](#step-1--deprecate-rule)
      - [STEP 2 : remove rule](#step-2--remove-rule)

## Basics

In order to develop a Sonarqube Plugin in Open source for ecocode, two basics must have been mastered:

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

<https://medium.com/android-news/gitflow-with-github-c675aa4f606a>

### Github GreenCodeInitiative

- common part (doc / tools) : <https://github.com/green-code-initiative/ecoCode-common>
- rules specification : <https://github.com/green-code-initiative/ecoCode>
- several mobile repositories
- several standard repositories
- several test project repositories

### References

#### 115 web rules details

<https://github.com/cnumr/best-practices>

#### 40+ android/iOS rules details

<https://github.com/cnumr/best-practices-mobile>

## Local development

### Requirements

#### Method 1 - Automatic check

Execute script verification (present in this repository in `tool_checks` directory) :

For Mac or Unix OS : `./check_requirements.sh`

For Windows OS :

- execute following script : `./check_requirements.bat`
- then check versions displayed

PS : if you have some problems with this script, please feel free to create a new issue here <https://github.com/green-code-initiative/ecoCode-common/issues>

#### Method 2 - Manual check

- install Docker : <https://docs.docker.com/get-docker/>
- Docker-compose : <https://docs.docker.com/compose/install/>
- Java JDK (and not only JRE) for Sonarqube plugin Development : <https://www.java.com/fr/download/manual.jsp>
- Maven for Sonarqube plugin Development : <https://maven.apache.org/download.cgi>
- Git : <https://git-scm.com/book/en/v2/Getting-Started-Installing-Git>

If you want, you can check following file to know what are min and max versions for each tool : <https://github.com/green-code-initiative/ecoCode-common/blob/main/tools/check_requirements/config.txt>

Then launch check commands as follows (and check versions displayed) :

```sh
docker --version
docker-compose --version
javap -version
mvn --version
git --version
```

### Clone the project

Clone the project with (standard, mobile or/and common) : please see all availables repositories here <https://github.com/orgs/green-code-initiative/repositories?type=all>

Example (with SSH) :
```sh
git clone git@github.com:green-code-initiative/ecoCode-java.git
```

### Start local environment

You will find all steps to start a local Sonarqube dev Environment here :

<https://github.com/green-code-initiative/ecoCode-common/blob/main/doc/INSTALL.md#howto-install-sonarqube-dev-environment>

### Choose your rule

Pick a plugin in the following table and check if a rule is waiting to be implemented.

| Plugin Language | Plugin Rules Ideas                                                                                                |
|-----------------|-------------------------------------------------------------------------------------------------------------------|
| Java            | https://github.com/green-code-initiative/ecoCode-java/issues?q=is%3Aissue+is%3Aopen+label%3A%F0%9F%92%A1rule-idea |
|                 |                                                                                                                   |

### Test your development

Each rule needs to have scripts in a specific language (i.e. Python, Rust, JS, PHP and JAVA) in order to test directly inside Sonarqube that the rule has been implemented.

To validate that the rule has been implemented, you need to execute a scan on those scripts. You will need sonar scanner: <https://docs.sonarqube.org/latest/analysis/scan/sonarscanner/>

## Publish your work

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

#### Definition Of Done of a PR

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

## Development Processes

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
