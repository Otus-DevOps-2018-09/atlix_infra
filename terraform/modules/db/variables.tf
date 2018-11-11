variable machine_type {
  description = "Machine type"
  default = "g1-small"
}
variable zone {
  description = "GCP zone"
  default     = "europe-north1-b"
}

variable public_key_path {
  description = "Path to the ssh public key "
}

variable private_key_path {
  description = "Path to the ssh private key"
}

variable db_disk_image {
  description = "App DB disk image"
  default = "reddit-db-base"
}

variable db_port {
  description = "Reddit DB port"
  default     = 27017
}

variable db_proto {
  description = "Reddit DB protocol"
  default     = "tcp"
}
variable "app_provision_status" {
  description = "On / off app provisioning"
  default     = "false"
}