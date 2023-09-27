variable "tags" {
    description = "aks tags"
    type        = map(string)  
    default     =  {
        "org_name" = "tf-noops"
        "workload_name" = "AKSUDR"
        "deploy_environment" = "dev"
        "environment" = "USgov"
        "network_plugin" = "azure"
        "network_policy" = "calico"
    }
    }
variable "firewall_private_ip" {     
    description = "HUB Firewall private IP"
    type        = string
    default     = "10.8.4.68"  
}