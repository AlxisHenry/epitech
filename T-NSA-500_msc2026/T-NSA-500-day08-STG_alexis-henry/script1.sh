#!/bin/bash

if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <operand1> <operator> <operand2>"
    exit 1
fi

operand1=$1
operator=$2
operand2=$3

if ! [[ "$operand1" =~ ^[0-9]+$ ]] || ! [[ "$operand2" =~ ^[0-9]+$ ]]; then
    echo "Error: Operands must be numeric"
    exit 1
fi

# Perform calculations based on the operator provided
case $operator in
    +)
        result=$((operand1 + operand2))
        ;;
    -)
        result=$((operand1 - operand2))
        ;;
    *)
        result=$((operand1 * operand2))
        ;;
    ^)
        result=$((operand1**operand2))
        ;;
    /)
        # Check for division by zero
        if [ "$operand2" -eq 0 ]; then
            echo "Error: Division by zero is not allowed."
            exit 1
        fi
        result=$(awk "BEGIN {printf \"%.2f\", $operand1 / $operand2}")
        ;;
    *)
        echo "Invalid operator: $operator. Please use one of: + - \* ^ /"
        exit 1
        ;;
esac

# Output the result in the desired format
echo "Result: $result";