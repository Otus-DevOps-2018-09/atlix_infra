variable machine_type {
  description = "Machine type"
  default = "g1-small"
}
variable zone {
  description = "GCP zone"
  default     = "europe-north1-a"
}

variable public_key_path {
  description = "Path to the ssh public key "
}

variable private_key_path {
  description = "Path to the ssh private key"
}

variable app_disk_image {
  description = "App disk image"
  default = "reddit-app-base"
}

variable app_port {
  description = "Reddit app port"
  default     = 9292
}
variable nginx_port {
  description = "Reddit app nginx port"
  default     = 80
}

variable app_proto {
  description = "Reddit app protocol"
  default     = "tcp"
}

variable reddit_db_addr {
  description = "Mongo DB IP address"
}
variable "app_provision_status" {
  description = "On / off app provisioning"
  default     = "false"
}
