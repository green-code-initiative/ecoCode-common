#!/bin/bash

. _core.sh

debug "SONAR_TOKEN : $SONAR_TOKEN"
debug "SONAR_URL : $SONAR_URL"
debug "RULES_KEYS : $RULES_KEYS"
debug "TAG_ECODESIGN : $TAG_ECODESIGN"
debug "PROFILE_ECODESIGN : $PROFILE_ECODESIGN"
debug "PROFILES_LANGUAGE_KEYS : $PROFILES_LANGUAGE_KEYS"

# check SonarQube API connection
check_sonarapi

declare -i nb_profile_update=0

# loop on each profile to create a fork SonarWay with + New rules ecoconception
for language in "${PROFILES_LANGUAGE_ARRAY[@]}"
do
  echo -e "\n*****  Processing profile language ${BLUE}$language${NC}  *****"

  debug "Set 'Sonar way' profile to Default"
  set_default_profile "$language" "Sonar+way"

  debug "Delete existing '$PROFILE_ECODESIGN' profile for '$language' language"
  delete_profile_sonarapi "$language" "$PROFILE_ECODESIGN"

  debug "Create '$PROFILE_ECODESIGN' profile for '$language' language"
  create_profile_sonarapi "$language" "$PROFILE_ECODESIGN"

  debug "Change parent profile to 'Sonar way' for '$PROFILE_ECODESIGN' profile and '$language' language"
  change_parent_profile_sonarapi "$language" "$PROFILE_ECODESIGN"

  # get profile data from Sonar API
  res_json=$(search_profile_sonarapi $language $PROFILE_ECODESIGN)
  key_profile=$(echo "$res_json" | jq -r '.profiles[].key')

  debug "Activate rules for language '$language' and key profile '$key_profile'"
  activate_rules_creedengo_profile_sonarapi "$language" "$key_profile" "$TAG_ECODESIGN"

  if [ $IS_PROFILE_ECODESIGN_DEFAULT == 1 ]; then
    debug "Set '$PROFILE_ECODESIGN' profile for language '$language' to Default"
    set_default_profile "$language" "$PROFILE_ECODESIGN"
  fi

  nb_profile_update+=1
done

echo -e "\n==> ${GREEN}$nb_profile_update${NC} profiles updated\n"
