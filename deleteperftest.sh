##!/bin/bash
## create array of ns names which match the prefix "small"
#
namespaces=$(kubectl get namespaces | grep small | awk '{print $1}')
#
## loop NAMESPACES and delete each namespace

for namespaces in $namespaces; do

    kubectl delete namespace $namespaces

    echo "Deleted namespace $namespaces"
 
done

echo "All Namespaces Deleted"