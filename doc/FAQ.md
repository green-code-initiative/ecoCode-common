Frequently Ask Questions
---

## I'm using default `Sonar Way` rules (with default `Sonar Way` profile). When I install one of creedengo plugins (ex : `creedengo-java plugin`), are new creedengo rules installed ? and how does the plugin do this ?

> When an creedengo plugin is installed by the marketplace, the rules are immediately available on SonarQube. You can find them if you go to "rules" tab, and select rules with tag `eco-design`. 
> 
> But by default, creedengo rules aren't set to an existing Sonarqube profile.
> 
> If you want to use creedengo rules (for one language for example), you have many ways to configure it :
> 1. create a new profile, then select all wanted rules (creedengo rules or not) for that new profile, and finally use this new profile as "default" profile for the selected language (or set a few projects to this new profile).
> 2. use our script to create ths kind of profile (explanation here : https://github.com/green-code-initiative/creedengo-common/blob/main/doc/HOWTO.md#initialize-default-profiles-for-creedengo-plugins) ... WARNING : the new profile created will be set as the default profile for your language !
> 3. update one of your current profiles you use with new available creedengo rules