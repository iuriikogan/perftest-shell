### 
Create Perf Test for each of the following

    Big files
    Small files but many
    Many namespaces
    High backup frequency / Short backup frequency

-------------------------------------------------------------------------------
#### ref perf test script


./createPerfTest 

--namespacePrexix=small 
--namespacesNumber=87 
--numberOfPVCPerNamespace=10 
--pvcSizeGb=30 
--size_of_files=1 
--churnRatePercentage=10
--storageClassName="Azure/AWS Storage Class"

#### it will create 87 namespace (small-1 small-2 small-3 ...)
#### each having 10 PVC of 30G with a deployment attached that create an 21 files that nearly fill up the PVC, the files are fill up from /dev/random
####
#### and the deployment update 10% of the files every hour (i/e if 10 files take up the pvc and the the churn is 10% then 1 file will be updated every hour from /dev/random)
#### then from this use case we can work on the kasten configuration to optimize the backup
#### of all this namespaces

#### we can test different layout and draw a general approach for setting up the resources
  #### kub Windows/Stagerring
  ####  ConcurentSnapshotConversion
  ####  CPU/RAM of the different k10 components