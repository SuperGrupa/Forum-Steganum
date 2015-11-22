#!/bin/bash

cat <<EOF >./public/build.json
{
  "branch": "$TRAVIS_BRANCH",
  "id": "$TRAVIS_BUILD_ID",
  "number": "$TRAVIS_BUILD_NUMBER",
  "date": "$(date +%Y-%m-%d) $(date +%H:%M:%S)",
  "tag": "$TRAVIS_TAG"
}
EOF
