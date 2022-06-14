#Palette environment info
variable "sc_host" {
  description = "Spectro Cloud Endpoint"
  default     = "api.spectrocloud.com"
}

variable "sc_api_key" {
  description = "Palette api key"
  sensitive   = true
}

variable "sc_project_name" {
  description = "Spectro Cloud Project (e.g: Default)"
  default     = "Default"
}

#Cluster Profile
variable "sc_cp_profile_name" {}
variable "sc_cp_profile_description" {}
variable "sc_cp_profile_tags" {}
variable "sc_cp_cloud" {}
variable "sc_cp_type" {}
variable "sc_cp_version" {}





