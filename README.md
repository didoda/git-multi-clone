# git-multi-clone
A shell that provides multiple repositories clone.

## Set clone.sh permission

Make `clone.sh` executable. I.e.: `chmod 755 clone.sh`.

## Setup source.json

Setup `source.json` according to your needs.

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

Launch it with `./clone.sh`.