#!/bin/bash

# set length
readarray length <<< $( cat projects.json | jq '. | length' )

# set current dir
here=$( pwd )

# cycle over json array elements
i=0
until [ $i -ge $length ]
do
  cd $here
  readarray destination <<< $( cat projects.json | jq -r ".[$i] | .destination" )

  # get repositories and cycle over them
  readarray repositories <<< $( cat projects.json | jq -r ".[$i] | .repositories" )
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
      if [[ $1 = "sync" ]]; then
        echo "sync $folder (fetch & pull)"
        cd $folder
        git fetch -p
        git pull -p
      else
        echo "$folder already cloned"
      fi
    fi
  done

  ((i=i+1))
done
