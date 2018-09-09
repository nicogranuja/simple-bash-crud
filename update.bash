#!/bin/bash

# Read and set global variables for the selected item
function readFileAndUpdateGlobalVars {
    read fileSimpleName fileName 
    read qty maxQty
    read desc

    itemSimpleName=$fileSimpleName
    itemName=$fileName
    quantity=$qty
    maxQuantity=$maxQty
    description=$desc
}

function updateItemFile {
    fileLocation=$1
    itemData="$itemSimpleName $itemName\n$quantity $maxQuantity\n$description"

    # Write and create .item file with the item data
    echo -e  $itemData > "$fileLocation"

    # Update the logs with the created file
    echo "UPDATED: $itemSimpleName $(date)" >> $queriesFile

    echo "SUCCESS file $itemSimpleName updated"
}

function getFieldsFromInputAndUpdateItem {
    fileLocation=$1

    # Read and store current item values
    readFileAndUpdateGlobalVars < $fileLocation

    # Get data from user
    read -p "Simple name (string with no whitespace): " readItemSimpleName
    read -p "Item name (string): " readItemName
    read -p "Current quantity (integer): " readQty
    read -p "Maximum quantity (integer): " readMaxQty
    read -p "Description (string): " readDesc

    # If a value was passed re-assign it
    [[ ! -z "$readItemSimpleName" ]] && itemSimpleName=$readItemSimpleName
    [[ ! -z "$readItemName" ]] && itemName=$readItemName
    [[ ! -z "$readQty" ]] && quantity=$readQty
    [[ ! -z "$readMaxQty" ]] && maxQuantity=$readMaxQty
    [[ ! -z "$readDesc" ]] && description=$readDesc

    updateItemFile $fileLocation
}

function updateFile {
    # Read item number
    read -p "Enter the item number for item to update: " itemNumber
    
    itemNumber=$itemNumber
    fileLocation="$dataFolder/$itemNumber.item"

    # Handle file read and error if file does not exist
    if [ -e "$fileLocation" ]; then
        getFieldsFromInputAndUpdateItem $fileLocation
    else
        # Print and log errors
        echo -e "\nERROR: item with number: $itemNumber not found"
    fi
}