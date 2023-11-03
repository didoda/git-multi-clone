#!/bin/bash

if [[ $1 = "help" ]]; then
  echo "./clone.sh                      # clone all from projects.json"
  echo "./clone.sh -g <group>           # clone repositories by group matching in projects.json"
  echo "./clone.sh sync                 # fetch and pull projects"
  echo "./clone.sh sync -g <group>      # fetch and pull repositories by group matching in projects.json"
  echo "./clone.sh help                 # show usage"
  exit
fi

while getopts ":g:" arg; do
    case "${arg}" in
        g)
            g=${OPTARG}
            ;;
    esac
done

# set length
readarray length <<< $( cat projects.json | jq '. | length' )

# set current dir
here=$( pwd )

# cycle over json array elements
i=0
until [ $i -ge $length ]
do
  cd $here

  # get group
  readarray group <<< $( cat projects.json | jq -r ".[$i] | .group" )
  group=$( echo "$group" | xargs )

  if [[ $g != '' && $g != $group ]]; then
    ((i=i+1))
    continue
  fi

  # get destination
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
      # remove last comma
      project=$( echo "${repository%,*} ${repository##*,}" )
      project=$( basename "$project" ".${project##*.}")
      repository=$( echo "${repository%,*} ${repository##*,}" )
    else
      project=$( basename "$repository" ".${repository##*.}" )
    fi
    repository=$( echo "$repository" | tr -d '"')
    destination=$( echo "$destination" | xargs )
    folder=$( echo "$destination/$project" | tr -d '"')
    folder=$( echo "$folder" | xargs )

    # clone project, if not existing
    if [ ! -d "$folder" ]; then
      git clone $repository $folder
    else
      if [[ cmd = "sync" ]]; then
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
