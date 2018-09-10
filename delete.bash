#!/bin/bash

function deleteFile {
    # Read the item number
    read -p "Enter an item number: " itemNumber

    fileLocation="$dataFolder/$itemNumber.item"
    
    # Handle file read and error if file does not exist
    if [[ -e "$fileLocation" ]]; then
        # Get simple name
        read simpleName name < $fileLocation
        
        # Delete the file from the file system
        rm $fileLocation
        
        echo -e "\n$simpleName was successfully deleted"
        echo "DELETED: $fileName $(date)" >> $queriesFile
    else
        # Print and log errors
        echo -e "\nERROR: item with number: $itemNumber not found"
    fi
}