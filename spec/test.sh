#!/bin/bash

cd $(dirname $0)
terragrunt apply-all --terragrunt-non-interactive
rake spec
RESULT=$?
if [ $RESULT -eq 0 ]; then
  echo tests succeeded 
  terragrunt destroy-all --terragrunt-non-interactive
else
  echo failed
  # Destroy unless we request not to
  [[ ! -z "$LEAVE_INFRA" ]] ||  terragrunt destroy-all --terragrunt-non-interactive 
fi
