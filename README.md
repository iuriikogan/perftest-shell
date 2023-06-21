-------------------------------------------------------------------------------

## Kasten Performance Test enviroment 
#### ./createPerfTest.sh will create a number of namespaces and deployments of busybox which will mount a pvc with $storageclassname with $number_of_files from /dev/urandom of size $pcvSizeGi - $COMMAND function
#### ./churnPerfTest.sh will exec into each pod and delete $NUM_OF_FILES replacing with $NUM_OF_FILES of $FILE_SIZE
### *****SET ENVS in createPerfTest.sh

#### NUM_NAMESPACES=3
#### NAMESPACE_PREFIX="small"
#### IMAGE_NAME="busybox:latest"
#### PVC_SIZE="30Gi"
#### NUMBER_OF_FILES=30
#### SIZE_OF_FILES="1GB"
#### NUM_PVC_PER_NS=3
#### STORAGE_CLASS="managed-premium"

### ./createPerfTest 

### Create churn of each replicas/pvcs files based on the churnratepercentage
### *******Set ENVs in churnPerfTest.sh
#### NAMESPACE_PREFIX="small"
#### NUM_FILES_TO_CHURN=5
#### SIZE_OF_FILES="1Gb"


### ./churnPerfTest

### Delete all namespaces based on the $NAMESPACE_PREFIX
### ./deletePerfTest
#### ******grep for $NAMESPACE_PREFIX from createPerfTest.sh
