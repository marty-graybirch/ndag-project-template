#!/bin/bash
#
# Unset environment variables for utility scripts used in the NFV git repository.

PROJECT=${NFV_PROJECT}

PATH="${PATH#${NFV_BIN}:}"

unset NFV_BIN
unset NFV_ROOT
unset NFV_PROJECT

export PATH

[[ ! $(type deactivate | grep -q function) ]] && deactivate

printf "\nYour environment has been cleared for the NFV repository %s\n" $PROJECT
printf "Your Python environment has been restored to the system environment."
printf "You will need to source bin/setenv.sh again before working in this project space.\n\n"

