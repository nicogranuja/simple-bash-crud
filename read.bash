#!/bin/bash

function printItem {
    read fileSimpleName fileName 
    read qty maxQty
    read desc

    echo -e "\nItem name: $fileName"
    echo "Simple name: $fileSimpleName"
    echo "Item Number: $1"
    echo "Qty: $qty/$maxQty"
    echo "Description $desc"
}

function handleReadFile {
    itemNumber=$1
    fileLocation="$dataFolder/$itemNumber.item"

    # Handle file read and error if file does not exist
    if [[ -e "$fileLocation" ]]; then
        # TODO read contents and print them
        printItem $itemNumber < $fileLocation

    else
        # Print and log errors
        echo -e "\nERROR: item with number: $itemNumber not found"
    fi
}

function readFile {
    # Read the item number
    read -p "Enter an item number: " itemNumber
    
    handleReadFile $itemNumber
}