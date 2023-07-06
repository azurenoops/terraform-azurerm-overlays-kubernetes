# Copyright (c) Microsoft Corporation.
# Licensed under the MIT License.

locals {
  tags = {
    Project = "Azure NoOps"
    Module  = "overlays-aks-private-cluster"
    Toolkit = "Terraform"
    Example = "basic deployment of aks private cluster"
  }
}