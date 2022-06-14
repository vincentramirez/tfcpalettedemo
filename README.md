To use these TF configs

cd into cp-v1-0-0_run_first
modify the terraform.tfvars file and put your palette api key into the file
terraform apply

This will create the first version of the cluster profile at k8s version 1.21.10

cd into cp-v1-0-1_run_second
modify the terraform.tfvars file and put your palette api key into the file
terraform apply

This will create the second version of the cluster profile at k8s version 1.22.7

cd into cluster_run_third
modify the terraform.tfvars file and put your palette api key, and aws access keys
terraform apply

This will create an AWS IaaS cluster based on the Cluster Profile version 1.0.0

After this cluster povisioning completes
Modify the terraform.tfvars file line 31 to version 1.0.1
terraform apply

This will update the Cluster Profile version and Palette will detect this change
which will trigger a rolling upgrade in Palette on the CP nodes and Worker nodes


