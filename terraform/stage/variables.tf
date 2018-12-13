variable vm_type {
  description = "VM type"
  default     = "g1-small"
}
variable project {
  description = "GCP project ID"
}

variable region {
  description = "GCP region"
  default     = "europe-north1"
}

variable zone {
  description = "GCP zone"
  default     = "europe-north1-c"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable private_key_path {
  description = "Path to the private key used for ssh access"
}

variable db_disk_image {
  description = "DB disk image"
}

variable app_disk_image {
  description = "App disk image"
}

variable "app_provision_status" {
  description = "On / off app provisioning"
  default     = "false"
}
