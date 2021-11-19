variable "project_id" {}
variable "project_name" {
  default = "dockerized-flask-on-gce"
}
variable "repository_name" {
  default = "dockerized-flask-on-gce"
}
variable "region" {
  default = "europe-west2-b"
}
variable "zone" {
  default = "europe-west2-b"
}
variable "service_account_email" {
  default = "dockerized-flask-on-gce-1000@dockerized-flask-on-gce-331711.iam.gserviceaccount.com"
}
