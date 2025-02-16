#!/bin/sh

gpg \
    --quiet --batch --yes --decrypt \
    --passphrase="$PASSPHRASE" \
    --output $OUTPUT \
    $INPUT