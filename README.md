-------------------------------------------------------------------------------

### createPerfTest will create a number of namespaces and deployments of busybox which will mount a pvc with $storageclassname with $number_of_files from /dev/urandom of size $pcvSizeGi - $COMMAND function
./createPerfTest 

--namespacePrexix=small 
--namespacesNumber=87 
--numberOfPVCPerNamespace=10 
--pvcSizeGi=30 
--size_of_files=1 
--storageClassName=""

#### Create churn of each replicas/pvcs files based on the churnratepercentage
./churnPerfTest

--churnratepercentage=10


#### Delete all namespaces based on the $NAMESPACE_PREFIX
./deletePerfTest

--namespacePrexix=small
