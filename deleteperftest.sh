##!/bin/bash
## create array of ns names which match the prefix "small"
NAMESPACES=$(kubectl get namespaces | grep small | awk '{print $1}')
## loop NAMESPACES array and delete each namespace
FOR NAMESPACE IN $NAMESPACES DO
    kubectl delete namespace $NAMESPACE
    echo "Deleted namespace $NAMESPACE"
done