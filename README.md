## This Terraform example demonstrates 
- Creating a Palette Cluster Profile
- Creating a second version of the same Cluster Profile (changing the K8s version)
- Creating a K8s cluster using the Cluster Profiles on AWS IaaS

## To use these TF configs

- Clone the repo which consists of 3 separate directories
- Install Terraform ≥ 1.0.x  

## Create a cluster profile v1.0.0
- cd into the dir `cp-v1-0-0_run_first`
- Make a copy of the terraform.tfvars.example file and name it `terraform.tfvars`
- Modify the `terraform.tfvars` file by adding your palette api key to line #11
- Run Terraform `terraform apply`
- Verify the cluster profile is created in Palette > Default Project > Profiles 

This will create the first version of the cluster profile at k8s version 1.22.7
which can be found in the file `resource_clusterprofile.tf` line #66

## Create a second cluster profile v1.0.1
- cd into the dir `cp-v1-0-1_run_second`
- Make a copy of the terraform.tfvars.example file and name it `terraform.tfvars`
- Modify the `terraform.tfvars` file by adding your palette api key to line #11
- Run Terraform `terraform apply`
- Verify the cluster profile version is created in Palette > Default Project > Profiles 

This will create the second version of the cluster profile at k8s version 1.23.4
which can be found in the file `resource_clusterprofile.tf` line #66


## Create an AWS IaaS cluster based on the cluster profile v1.0.0
- cd into the dir `cluster_run_third`
- Make a copy of the terraform.tfvars.example file and name it `terraform.tfvars`
- Modify the `terraform.tfvars` file:  
	- adding your palette api key to line #11
	- add AWS access keys to lines #24 & #25
	- verify line #31 is set to "1.0.0"
	- paste an ssh public key blob into line #41
	- update the AWS region you would like to use line #45
	- save changes to file 
- Run Terraform `terraform apply`
- Verify the cluster is created in Palette > Clusters creation will take ~20-30mins

This will create an AWS IaaS cluster based on the Cluster Profile version 1.0.0

## Update the cluster to use cluster profile v1.0.1
After the cluster povisioning completes
- cd into the dir `cluster_run_third`
- Modify the `terraform.tfvars` file line 31 from 1.0.0 to version 1.0.1
- save changes to the file
- Run Terraform `terraform apply`

This will update the Cluster Profile version and Palette will detect this change
which will trigger a rolling upgrade in Palette on the CP nodes and Worker nodes
You can watch this in Palette > Clusters > ClusterName > Nodes tab

## Clean up 
To clean up
- First cd into the dir `cluster_run_third` and run `terraform destroy`
- Second cd into the dir `cp-v1-0-1_run_second` and run `terraform destroy`
- Third cd into the dir `cp-v1-0-0_run_first` and run `terraform destroy`


