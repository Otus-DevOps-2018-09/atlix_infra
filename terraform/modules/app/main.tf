data "template_file" "reddit_app_systemd" {
    template = "${file("${path.module}/files/puma.service.tpl")}"

    vars {
	    reddit_db_addr = "${var.reddit_db_addr}"
    }
}

resource "google_compute_instance" "app" {
  name = "reddit-app"
  machine_type = "${var.machine_type}"
  zone         = "${var.zone}"
  tags         = ["reddit-app"]

  metadata {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }

  boot_disk {
    initialize_params {
      image = "${var.app_disk_image}"
    }
  }

  network_interface {
    network = "default"

    access_config {
      nat_ip = "${google_compute_address.app_ip.address}"
    }
  }
}
resource "null_resource" "app" {
  count = "${var.app_provision_status ? 1 : 0}"

  connection {
    type        = "ssh"
    user        = "appuser"
    agent       = false
    private_key = "${file(var.private_key_path)}"
  }
  provisioner "file" {
    content      = "${data.template_file.reddit_app_systemd.rendered}"
    destination = "/tmp/puma.service"
  }

  provisioner "remote-exec" {
    script = "${path.module}/files/deploy.sh"
  }
}

resource "google_compute_firewall" "firewall_puma" {
  name    = "allow-puma-default"
  network = "default"

  allow {
    protocol = "${var.app_proto}"
    ports    = ["${var.app_port}","${var.nginx_port}"]

  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["reddit-app"]
}

resource "google_compute_address" "app_ip" {
  name = "reddit-app-ip"
}
