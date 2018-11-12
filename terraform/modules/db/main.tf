resource "google_compute_instance" "db" {
  name         = "reddit-db"
  machine_type = "${var.machine_type}"
  zone         = "${var.zone}"
  tags         = ["reddit-db"]

  boot_disk {
    initialize_params {
      image = "${var.db_disk_image}"
    }
  }

  network_interface {
    network       = "default"
    access_config = {}
  }

  metadata {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }
}
resource "null_resource" "db" {
  count = "${var.app_provision_status ? 1 : 0}"

  connection {
    type        = "ssh"
    user        = "appuser"
    agent       = false
    private_key = "${file(var.private_key_path)}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo -- sh -c 'sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf && systemctl restart mongod'"
    ]
  }
}
resource "google_compute_firewall" "firewall_mongod" {
  name    = "allow-mongod-default"
  network = "default"

  allow {
    protocol = "${var.db_proto}"
    ports    = ["${var.db_port}"]
  }

  target_tags   = ["reddit-db"]
  source_tags   = ["reddit-app"]
}