#!/bin/bash

REPO_PATH=https://github.com/furiel/ansdepl.git
TMP_FILES=/var/pull

ansible-pull -o -v -U "$REPO_PATH" -d "$TMP_FILES" -i "localhost," -c local ansdepl.yml

while [[ $RESULT -ne 0 ]] && [ $COUNTER -lt 10 ]; do
  echo "+++Could not pull | $COUNTER. Try"
  COUNTER=$[COUNTER + 1]
  sleep 10

  ansible-pull -p -U "$REPO_PATH" -d "$TMP_FILES" -i "localhost," -c local ansdepl.yml
  RESULT=$?
done

if [[ $RESULT -eq 11 ]];
then
  exit 1;
else
  exit 0;
fi
