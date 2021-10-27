#!/bin/bash

# set length
readarray length <<< $( cat source.json | jq '. | length' )

# cycle over json array elements
i=0
until [ $i -ge $length ]
do
  readarray destination <<< $( cat source.json | jq -r ".[$i] | .destination" )

  # get repositories and cycle over them
  readarray repositories <<< $( cat source.json | jq -r ".[$i] | .repositories" )
  for repository in ${repositories[@]}
  do
    if [[ $repository = "[" || $repository = "]" ]]; then
      continue;
    fi

    # create dir, if not existing
    if [ ! -d $destination ]; then
      mkdir $destination
    fi

    # set vars to build destination path
    if [[ "$repository" == *, ]]; then
      project=$( basename "$repository" ".${repository##*.}" )
      repository=$( echo "${repository%,*} ${repository##*,}" )
    else
      project=$( basename "$repository" ".${repository##*.}" )
    fi
    repository=$( echo "$repository" | tr -d '"')
    destination=$( echo "$destination" | xargs )
    folder=$( echo "$destination/$project" | tr -d '"')

    # clone project, if not existing
    if [ ! -d "$folder" ]; then
      git clone $repository $folder
    else
      echo "$folder already cloned"
    fi
  done

  ((i=i+1))
done
