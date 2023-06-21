#!/bin/bash

# Set the number of namespaces to create

NUM_NAMESPACES=3
NAMESPACE_PREFIX="small"

# Set the image name for the busybox container

IMAGE_NAME="busybox"

# Set the PVC size number of PVC (replicas of deployment)and storage class

PVC_SIZE="30Gi"
NUMBER_OF_FILES=30
SIZE_OF_FILES="1GB"
NUM_PVC_PER_NS=3
STORAGE_CLASS="managed-premium"

# Set the command to run in the busybox container

COMMAND="dd if=/dev/urandom of=/data/file\$i bs=$SIZE_OF_FILES count=$NUMBER_OF_FILES"

# Loop to create namespaces and deployments
for ((i=1; i<=NUM_NAMESPACES; i++))
do
  NAMESPACE="$NAMESPACE_PREFIX-$i"

  # Create the namespace
  kubectl create namespace $NAMESPACE
  # Create the PVCs and deployments for $NUM_OF_PVC_PER_NS
  for ((j=1; j<=NUM_PVC_PER_NS; j++)); do
    # Create the PVC for each Deploy 
    kubectl -n $NAMESPACE apply -f - <<EOF
    apiVersion: v1
    kind: PersistentVolumeClaim
    metadata:
      name: pvc-$NAMESPACE-$j
    spec:
      accessModes:
        - ReadWriteOnce
      resources:
        requests:
          storage: $PVC_SIZE
      storageClassName: $STORAGE_CLASS
EOF

# Create the deployment
    kubectl -n $NAMESPACE apply -f - <<EOF
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: busybox-deployment-$NAMESPACE-$j
    spec:
      replicas: 1
      selector:
        matchLabels:
          app: busybox
      template:
        metadata:
          labels:
            app: busybox
        spec:
          containers:
            - name: busybox-$NAMESPACE-$j
              image: $IMAGE_NAME
              command: ["/bin/sh", "-c", $COMMAND; "done"]
              volumeMounts:
              - name: data
              mountPath: /data
        volumes:
        - name: data
          persistentVolumeClaim:
            claimName: pvc-$NAMESPACE-$j
EOF
  done
    echo "deployment and PVC created for deployment $NAMESPACE-$j"
done
  echo "Created namespace $NAMESPACE"