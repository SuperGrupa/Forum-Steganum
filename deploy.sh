#!/bin/bash
set timeout 1000
set email "$env(METEOR_EMAIL)"
set password "$env(METEOR_PASSWORD)"

if [ "$TRAVIS_BRANCH" == "develop" ]; then

  spawn meteor deploy $env(METEOR_DEPLOY_URL)

  expect -- "*Email:"
  send "$email\n"
  expect -- "*assword:"
  send -- "$password\n"
  expect -- "*Now serving at $env(METEOR_DEPLOY_URL)"

fi
