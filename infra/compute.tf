data "google_compute_image" "cos" {
  family  = "cos-stable"
  project = "cos-cloud"
}

data "google_compute_default_service_account" "default" {}

resource "google_compute_instance" "container_optimized_os_vm_for_dockerized-flask-on-gce" {
  name                      = "container-optimized-os-vm-for-dockerized-flask-on-gce"
  machine_type              = "f1-micro"
  allow_stopping_for_update = true

  network_interface {
    network = "default"
    access_config {}
  }

  boot_disk {
    initialize_params {
      image = data.google_compute_image.cos.self_link
    }
  }

  service_account {
    email = var.service_account_email
    scopes = [
      "cloud-platform"
    ]
  }

  metadata = {
    gce-container-declaration = <<EOT
spec:
  containers:
    - image: blairnangle/python3-numpy-ta-lib:latest
      name: containervm
      securityContext:
        privileged: false
      stdin: false
      tty: false
      volumeMounts: []
      restartPolicy: Always
      volumes: []
EOT
    google-logging-enabled    = "true"
  }

  tags = [
    "dockerized-flask-on-gce",
    "http-server",
    "https-server"
  ]
}

resource "google_compute_firewall" "http" {
  name    = "default-allow-http"
  network = "default"

  allow {
    protocol = "tcp"
    ports = [
      "80"
    ]
  }

  // Allow traffic from everywhere to instances with a https-server tag
  source_ranges = [
    "0.0.0.0/0"
  ]
  target_tags = [
    "http-server",
  ]
}

resource "google_compute_firewall" "https" {
  name    = "default-allow-https"
  network = "default"

  allow {
    protocol = "tcp"
    ports = [
      "443"
    ]
  }

  // Allow traffic from everywhere to instances with a https-server tag
  source_ranges = [
    "0.0.0.0/0"
  ]
  target_tags = [
    "https-server"
  ]
}
