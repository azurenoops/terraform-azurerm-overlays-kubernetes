# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

terraform {
  required_version = ">= 1.3"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.22"
    }   
    azurenoopsutils = {
      source  = "azurenoops/azurenoopsutils"
      version = "~> 1.0.4"
    }
    /*
    azurecaf = {
      source = "aztfmod/azurecaf"
      version = "2.0.0-preview3"
    }
  */
  }
}
