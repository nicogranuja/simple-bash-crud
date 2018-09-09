#!/bin/bash

set -eo pipefail

# Global variables
queriesFile="$PWD/data/queries.log"
dataFolder="$PWD/data"

itemNumber=0
itemSimpleName=""
itemName=""
quantity=0
maxQuantity=0
description=""

# Check if needed folders and files exist and create them if they don't
if [ ! -d "$dataFolder" ]; then 
    echo "data folder not found creating it..."
    mkdir data
fi

if [ ! -e "$queriesFile" ]; then 
    echo "queries.log file not found creating it..."
    touch data/queries.log
    chmod u+rw data/queries.log
fi

# Get functionality from the CRUD files
source ./create.bash
source ./read.bash
source ./update.bash
source ./delete.bash


# Creating infinite while loop
keppGoing=0

while [ $keppGoing ]; do
    echo -e "\nEnter one of the following actions or press CTRL-D to exit."
    echo "C - create a new item"
    echo "R - read an existing item"
    echo "U - update an existing item"
    echo "D - delete an existing item"

    # Prevent while loop from continuing until next read
    if ! read ans; then
        # got EOF
        break
    fi

    # CRUD options
    case "$ans" in
        C|c) 
            createFile;;
        R|r) 
            readFile;;
        U|u) 
            updateFile;;
        D|d)
            deleteFile;;
        *)  
            echo "ERROR: invalid option"
    esac
done
