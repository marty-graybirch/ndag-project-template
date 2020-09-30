#!/bin/bash
#
# Set up environment variables for utility scripts used in the NFV git repository.

NFV_BIN=$(cd $(dirname -- $0) ; pwd -P)
NFV_ROOT=${NFV_BIN%/bin}
NFV_PROJECT=$( basename "${NFV_ROOT}" )

# Check for Python and see if virtual environment has been set up

PYTHON=$(which python3)

if [[ ! -f $PYTHON ]];
then
    echo ""
    echo "**** WARNING ****"
    echo "Python3 is not installed on this system."
    echo "Many of the utilities in this project rely on Python3."
    echo "To make full use of the utilities provided you should install Python3 on your system."
    echo "Typically:"
    echo "   $ sudo apt install python3 (Ubuntu)"
    echo "   $ sudo yum install -y python3 (CentOS)"
    echo "   $ brew install python3 (MacOS using Homebrew)"
    echo "Windows users should install Windows System for Linux instead of trying to use this library in"
    echo "command prompt or PowerShell"
    echo ""
else
    if [[ ! -f $NFV_ROOT/.venv/bin/activate ]];
    then
        printf "\nNo Python virtual environment found.\n"
        printf "Creating a Python virtual environment will ensure compatibility with the tools in this project.\n"
        while true; do
            printf "Do you wish to create a new virtual environment for this project? (y/n) "
            read ANS
            case $ANS in
                [Yy]* )
                    echo "Creating a Python3 virtual environment in $NFV_PROJECT/.venv"
                    $PYTHON -m venv $NFV_ROOT/.venv
                    source $NFV_ROOT/.venv/bin/activate
                    PYTHON=$(which python)
                    PIP=$(which pip)
                    echo "Upgrading PIP ..."
                    $PYTHON -m pip install --upgrade pip
                    echo "Installing Python libraries from bin/requirements.txt ..."
                    $PIP install -r $NFV_ROOT/bin/requirements.txt
                    deactivate
                    echo ""
                    echo "Your python virtual environment has been created in $NFV_PROJECT/.venv"
                    echo "To activate the virtual environment 'source $NFV_PROJECT/.venv/bin/activate'."
                    echo "Most utilities provided in this project will set the virtual environment before execution."
                    echo ""
                    break;;
                [Nn]* ) break;;
                * ) echo "Please answer yes or no.";;
            esac
        done
    fi
fi

if [[ ${PATH} =~ ${NFV_BIN} ]];
then
    printf "Warning: Directory %s/bin is already in your PATH.\n" $NFV_PROJECT
else
    PATH="${NFV_BIN}:${PATH}"
fi

export NFV_BIN
export NFV_ROOT
export NFV_PROJECT
export PATH

source $NFV_ROOT/.venv/bin/activate


printf "Your environment has been set up for the NFV repository %s.\n" $NFV_PROJECT
printf "This script has set several environment variables and added the %s/bin directory to your PATH.\n" $NFV_PROJECT
printf "This script has activated the project's Python virtual environment.\n ==> Use caution when running python scripts outside the project.\n"
printf "Please source bin/unsetenv.sh to clear the environment variables before moving to a different project space.\n\n"
