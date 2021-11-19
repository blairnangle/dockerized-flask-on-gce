resource "google_project_service" "enable_artifact_registry_for_project" {
  project = var.project_id
  service = "artifactregistry.googleapis.com"
}

resource "google_artifact_registry_repository" "dockerized-flask-on-gce" {
  depends_on = [
    google_project_service.enable_artifact_registry_for_project
  ]

  provider = google-beta

  project       = var.project_id
  location      = "europe-west2"
  repository_id = "dockerized-flask-on-gce"
  description   = "Repository for dockerized-flask-on-gce Docker images"
  format        = "DOCKER"
}
