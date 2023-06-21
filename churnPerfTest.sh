#!/bin/bash
## set env vars
NAMESPACE_PREFIX="small"
NUM_FILES_TO_CHURN=5
SIZE_OF_FILES="1Gb"
COMMAND="rm /data/files/file\$i; dd if=/dev/random of=data/files/file$i bs=$SIZE_OF_FILES count=1; SLEEP 60"

# Get the list of namespaces with the prefix
namespaces=$(kubectl get namespaces | grep small | awk '{print $1}')
# Loop through each namespace 
for namespaces in $namespaces; do
  # Loop through each pod in the namespace
  for pod in $(kubectl get pods -n "$namespaces" -o=jsonpath='{.items[*].metadata.name}'); do
    # Loop through $NUM_OF_FILES_TO_CHURN in the pod
    echo "Deleting from Pod: $pod"
    for ((i=1; i<=$NUM_FILES_TO_CHURN; i++)); do
      # delete file and replace with new file from dev/random for NUM_FILES
      kubectl exec -n "$namespaces" "$pod" -- "/bin/sh", "-c", $COMMAND; "done"
      echo "$i Files replaced."

    done

   echo "pod done."

  done

  echo "Namespace done."

done