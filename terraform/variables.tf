variable app_name {
  description = "Reddit app name"
  default     = "reddit-app"
}

variable app_port {
  description = "Reddit app port"
  default     = 9292
}

variable app_proto {
  description = "Reddit app protocol"
  default     = "tcp"
}

variable project {
  description = "GCP project ID"
}

variable region {
  description = "GCP region"
  default     = "europe-west3"
}

variable zone {
  description = "GCP zone"
  default     = "europe-west3-a"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable private_key_path {
  description = "Path to the private key used for ssh access"
}

variable disk_image {
  description = "Disk image"
}

variable count {
  description = "Instance count"
  default     = 1
}
