#!/bin/bash
## set env vars
NAMESPACE_PREFIX="small"
NUM_FILES=5
FILE_SIZE="1Gb"

# Get the list of namespaces with the prefix
namespaces=$(kubectl get namespaces | grep small | awk '{print $1}')
# Loop through each namespace 
for namespaces in $namespaces; do
  # Loop through each pod in the namespace
  for pod in $(kubectl get pods -n "$namespaces" -o=jsonpath='{.items[*].metadata.name}'); do
    echo "  Pod: $pod"
    for ((i=1; i<=$NUM_FILES; i++)); do
      # delete file and replace with new file from dev/random for NUM_FILES
      kubectl exec -n "$namespace" "$pod" -- "rm /data/files/file\$i &&
      dd if=/dev/random of=data/files/file$i bs=$FILE_SIZE count=1"
    done

    echo "$NUM_FILES Files replaced."
  done

  echo "Namespace done."
done