# Basics

In order to develop a Sonarqube Plugin in Open source for ecocode, two basics must have been mastered:

* How to develop a Sonarqube plugin
* Understand and work with the Gitflow

### Sonarqube Plugin

https://docs.sonarqube.org/latest/extend/developing-plugin/

#### How a SonarQube plugin works

Code is parsed to be transformed as AST. AST will allow you to access one or more nodes of your code.
For example, you’ll be able to access of all your `for` loop, to explore content etc.

To better understand AST structure, you can use the [AST Explorer](https://astexplorer.net/).

JavaScript plugin works differently because it does not use AST. [More information here](javascript-plugin/README.md)

### Gitflow

https://medium.com/android-news/gitflow-with-github-c675aa4f606a

### Github GreenCodeInitiative

* standard part : https://github.com/green-code-initiative/ecoCode
* mobile part : https://github.com/green-code-initiative/ecoCode-mobile
* linter part : https://github.com/green-code-initiative/ecoCode-linter
* common part (doc / tools) : https://github.com/green-code-initiative/ecoCode-common
* several test project repositories

### 115 web rules details

https://github.com/cnumr/best-practices

### 40+ android/iOS rules details

https://github.com/cnumr/best-practices-mobile

# Local development

### Requirements

Method 1 - Execute script verification (present in this repository in `tool_checks` directory) :

For Mac or Unix OS : `./check_requirements.sh`

For Windows OS :

* execute following script : `./check_requirements.bat`
* then check versions displayed

Method 2 - Check manually your tools :

* install Docker : https://docs.docker.com/get-docker/
* Docker-compose 3.9 : https://docs.docker.com/compose/install/
* Java >=11 for Sonarqube plugin Development : https://www.java.com/fr/download/manual.jsp
* Maven 3 for Sonarqube plugin Development : https://maven.apache.org/download.cgi
* Git : https://git-scm.com/book/en/v2/Getting-Started-Installing-Git

Then launch check commands as follows (and check versions displayed) :

```sh
docker --version
docker-compose --version
javap -version
mvn --version
git --version
```

### Clone the project

Clone the project with (standard, mobile or/and common) :

```sh
git clone https://github.com/green-code-initiative/ecoCode
git clone https://github.com/green-code-initiative/ecoCode-mobile
git clone https://github.com/green-code-initiative/ecoCode-common
```

### Start local environment

You will find all the steps to start a Sonarqube dev Environment here :

* standard : https://github.com/green-code-initiative/ecoCode/blob/main/INSTALL.md
* mobile : https://github.com/green-code-initiative/ecoCode-mobile/blob/main/INSTALL.md

### Choose your rule

Choose a rule in a specific language in the "To do" column : https://github.com/cnumr/ecoCode/projects/1 and move it to the "In progress"

### Test your development

Each rule needs to have scripts in a specific language (i.e. Python, Rust, JS, PHP and JAVA) in order to test directly inside Sonarqube that the rule has been implemented.

To validate that the rule has been implemented, you need to execute a scan on those scripts. You will need sonar scanner: https://docs.sonarqube.org/latest/analysis/scan/sonarscanner/

# Publish your work

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

You may have to log with your account : https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token

### Open pull request

Once your code is pushed and tested, open a PR between your branch and "main" : https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request

### Review others development

Ask to people to review your PR. Once two people, at least, have reviewed, you can validate your PR
If you want to be reviewed, review others... It's a win/win situation

### Validation of a PR

Validate your PR or ask to someone who have the permissions to validate your PR.
Once PR validated, a github workflow is automatically launched. Thus, the new implemented code is also scan with our internal Sonar to check the implemented code quality.
Here is the SonarQube : https://sonarcloud.io/organizations/green-code-initiative/projects

### Close your rule

Once your PR is validated, your rule integrates ecoCode. In https://github.com/cnumr/ecoCode/projects/1, move it from the "In Progress" column to the "Done" column.
Well done.
