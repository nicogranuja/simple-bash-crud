#!/bin/bash

# Read the new item fields from user
function readFieldsFromUserInput {
    read -p "Item number (four digit integer): " itemNumber
    read -p "Simple name (string with no whitespace): " itemSimpleName
    read -p "Item name (string): " itemName
    read -p "Current quantity (integer): " quantity
    read -p "Maximum quantity (integer): " maxQuantity
    read -p "Description (string): " description
}

function createNewItem {
    fileName="$itemNumber.item"

    # If the file with the item number already exists
    if [[ -e "$dataFolder/$fileName" ]]; then
        echo -e "ERROR: File $fileName already exists"
    else
        itemData="$itemSimpleName $itemName\n$quantity $maxQuantity\n$description"

        # Write and create .item file with the item data
        echo -e  $itemData > "$dataFolder/$fileName"

        # Update the logs with the created file
        echo "CREATED: $itemSimpleName $(date)" >> $queriesFile

        echo "SUCCESS file $fileName created"
    fi
}

# Function in charge of creating a file
function createFile {
    echo -e "\nPlease follow the steps to create a file.\n"

    readFieldsFromUserInput

    createNewItem
}
