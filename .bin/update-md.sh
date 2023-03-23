#!/bin/bash
pwd=$(pwd)
for dir in $(ls -d modules/azure/* && ls -d modules/local/* && ls -d examples/azure/* && ls -d examples/local/*); do
    cd ${pwd}/${dir}
    sed '/## Requirements/,$d' README.md > tmp.md && mv tmp.md README.md
    terraform-docs markdown table . >> README.md
    sed '$ d' README.md > tmp.md && mv tmp.md README.md
done
cd ${pwd}