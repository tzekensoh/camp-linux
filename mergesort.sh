#!/bin/bash

merge() {
    local l=$1
    local m=$2
    local r=$3

    local n1=$((m - l + 1))
    local n2=$((r - m))

    local -a L
    local -a R

    for ((i = 0; i < n1; i++)); do
        L[$i]=${array[$((l + i))]}
    done
    for ((j = 0; j < n2; j++)); do
        R[$j]=${array[$((m + 1 + j))]}
    done

    local i=0
    local j=0
    local k=$l
    while [ $i -lt $n1 ] && [ $j -lt $n2 ]; do
        if [[ ${L[$i]} < ${R[$j]} ]]; then
            array[$k]=${L[$i]}
            i=$((i + 1))
        else
            array[$k]=${R[$j]}
            j=$((j + 1))
        fi
        k=$((k + 1))
    done

    while [ $i -lt $n1 ]; do
        array[$k]=${L[$i]}
        i=$((i + 1))
        k=$((k + 1))
    done

    while [ $j -lt $n2 ]; do
        array[$k]=${R[$j]}
        j=$((j + 1))
        k=$((k + 1))
    done
}

mergeSort() {
    local l=$1
    local r=$2

    if [ $l -lt $r ]; then
        local m=$((l + (r - l) / 2))

        mergeSort $l $m
        mergeSort $((m + 1)) $r

        merge $l $m $r
    fi
}

array=("d" "b" "a" "c" "e" "g" "p" "i")

echo "Original Array: ${array[@]}"

mergeSort 0 $(( ${#array[@]} - 1 ))

echo "Sorted Array: ${array[@]}"
