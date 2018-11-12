provider "google" {
  version = "1.19.1"
  project = "${var.project}"
  region  = "${var.region}"
}

module "app" {
  source           = "../modules/app"
  machine_type     = "${var.vm_type}"
  app_disk_image   = "${var.app_disk_image}"
  public_key_path  = "${var.public_key_path}"
  private_key_path = "${var.private_key_path}"
  zone             = "${var.zone}"
  reddit_db_addr   = "${module.db.db_internal_ip}"
  app_provision_status = "${var.app_provision_status}"
}

module "db" {
  source           = "../modules/db"
  machine_type     = "${var.vm_type}"
  db_disk_image    = "${var.db_disk_image}"
  public_key_path  = "${var.public_key_path}"
  private_key_path = "${var.private_key_path}"
  zone             = "${var.zone}"
  app_provision_status = "${var.app_provision_status}"
}

module "vpc" {
  source        = "../modules/vpc"
}
