# Git multi clone

![image](https://img.shields.io/badge/Shell-B238AC?style=for-the-badge&logoColor=white)

A shell that provides multiple repositories clone and sync.

## Set clone.sh permission

Make `clone.sh` executable. I.e.: `chmod 755 clone.sh`.

## Setup projects.json

Setup `projects.json` according to your needs.

```json
[
  {
    "group": "cake",
    "destination": "/workspace/cake",
    "repositories": [
      "git@github.com:cakephp/app.git",
      "git@github.com:cakephp/bake.git",
      "git@github.com:cakephp/cakephp.git",
      "git@github.com:cakephp/migrations.git"
    ]
  },
  {
    "group": "docs",
    "destination": "/workspace/docs",
    "repositories": [
      "git@github.com:cakephp/docs.git"
    ]
  }
]
```

In the example above, we want to clone 4 repositories into `/workspace/cake` folder, 1 repository into `/workspace/docs`.

## Dependencies

Install `jq`, if you don't have it already.

## Usage

You can obtain info about usage by `./clone.sh help`.

```shell
./clone.sh                      # clone all from projects.json
./clone.sh -g <group>           # clone repositories by group matching in projects.json
./clone.sh sync                 # fetch and pull projects
./clone.sh sync -g <group>      # fetch and pull repositories by group matching in projects.json
./clone.sh help                 # show usage
```

### Multi clone

Launch it with `./clone.sh`.

You can clone by group with '-g' argument. Using the example json above, if you want to clone just "docs" repositories:

```shell
./clone.sh -g docs
```

### Multi sync (fetch and pull)

Launching `./clone.sh sync`, the shell will do a `git fetch -p` and `git pull` in the repositories defined in `projects.json`.
