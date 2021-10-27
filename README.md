# Git multi clone

![image](https://img.shields.io/badge/Shell-B238AC?style=for-the-badge&logo=favella&logoColor=white)

A shell that provides multiple repositories clone.

## Set clone.sh permission

Make `clone.sh` executable. I.e.: `chmod 755 clone.sh`.

## Setup projects.json

Setup `projects.json` according to your needs.

```
[
  {
    "destination": "/workspace/cake",
    "repositories": [
      "git@github.com:cakephp/app.git",
      "git@github.com:cakephp/bake.git",
      "git@github.com:cakephp/cakephp.git",
      "git@github.com:cakephp/migrations.git"
    ]
  },
  {
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

### Multi clone

Launch it with `./clone.sh`.

### Multi sync (fetch and pull)

Launching `./clone.sh sync`, the shell will do a `git fetch -p` and `git pull` in the repositories defined in `projects.json`.