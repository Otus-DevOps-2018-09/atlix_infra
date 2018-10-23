resource "google_compute_instance_group" "reddit-lb" {
  name        = "reddit-lb"
  description = "LoadBalancer for reddit-app instances"

  instances = ["${google_compute_instance.app.*.self_link}"]

  named_port {
    name = "reddit-port"
    port = "${var.app_port}"
  }

  zone = "${var.zone}"
}

resource "google_compute_http_health_check" "reddit-hc" {
  name               = "reddit-hc"
  request_path       = "/"
  port               = "${var.app_port}"
  check_interval_sec = 5
  timeout_sec        = 3
}

resource "google_compute_backend_service" "reddit-back" {
  name          = "reddit-back"
  port_name     = "reddit-port"
  protocol      = "HTTP"
  timeout_sec   = 5
  health_checks = ["${google_compute_http_health_check.reddit-hc.self_link}"]

  backend {
    group = "${google_compute_instance_group.reddit-lb.self_link}"
  }
}

resource "google_compute_global_forwarding_rule" "reddit-fwd-rule" {
  name        = "reddit-fwd-rule"
  description = "reddit-fwd-rule"
  target      = "${google_compute_target_http_proxy.reddit-proxy.self_link}"
  port_range  = "80"
}

resource "google_compute_target_http_proxy" "reddit-proxy" {
  name        = "reddit-proxy"
  description = "reddit-proxy"
  url_map     = "${google_compute_url_map.reddit-url-map.self_link}"
}

resource "google_compute_url_map" "reddit-url-map" {
  name            = "reddit-url-map"
  description     = "reddit-url-map"
  default_service = "${google_compute_backend_service.reddit-back.self_link}"

  host_rule {
    hosts        = ["*"]
    path_matcher = "allpaths"
  }

  path_matcher {
    name            = "allpaths"
    default_service = "${google_compute_backend_service.reddit-back.self_link}"

    path_rule {
      paths   = ["/*"]
      service = "${google_compute_backend_service.reddit-back.self_link}"
    }
  }
}
