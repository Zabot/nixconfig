#!/bin/sh

local_secrets=./secrets
remote_secrets=de4910@de4910.rsync.net:secrets

case $1 in
  push)
    rsync -va $local_secrets/ $remote_secrets
    ;;

  pull)
    rsync -va $remote_secrets/ $local_secrets
    ;;

  track)
    echo track
    ;;

  help | "")
    echo "usage: $0 [push | pull | track]"
    echo -e "push\tSync the remote with the local secrets"
    echo -e "pull\tSync the local secrets with the remote"
    echo -e "track\tRecord new or deleted files in the git index"
    exit 0
    ;;

  *)
    echo "$0: '$1' is not a subcommand"
    echo "usage: $0 [push | pull | track]"
    exit 1
    ;;
esac

# Tell git about all of the files, but assume they are empty. They
# will be tracked so the flake will know about them, but we don't
# actually commit them. Its a little cursed, but I think its better
# then committing the ciphertext.
git add --intent-to-add $local_secrets/*
git update-index --assume-unchanged $local_secrets/*
