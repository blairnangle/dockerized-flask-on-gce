# dockerized-flask-on-gce

Bare-bones, Dockerized Flask app running on a Container-Optimized OS Google Compute Engine instance. Infrastructure
provisioning and deployment using GitHub Actions.

## Local development

### Installation

* Create a virtual environment:

```shell
$ python3 -m venv .venv
```
* Activate the virtual environment:

```shell
$ source .venv/bin/activate
```

* Install requirements:

```shell
$ pip install -r requirements.txt
```

### Building image

```shell
$ docker build -t dockerized-flask-on-gce:local .
```

### Running image

```shell
$ docker run -p 6969:6969 dockerized-flask-on-gce:local
```

## Deployment

### First time

- Manually create a project on Google Cloud Platform and make a note of the project ID (not the project number)
- Enable the following APIs for the project:
  - Google Compute Engine (GCE)—VM upon which the container will run
  - Identity and Access Management (IAM) API—this enables use of newly created service account
  - Artifact Registry API—private repository for Docker images
  - Cloud Resource Manager API—interacting with containers
- Create a service account with owner access to project
- Create service account key and download
- Manually create a storage bucket to act as the Terraform backend—this must be globally unique and must match the value
provided in `infra/main.tf`

### Configuring GitHub Actions

The following Secrets need to be set:

- `GCP_PROJECT_ID`
- `GCP_SERVICE_ACCOUNT_KEY`
- `GCP_SERVICE_ACCOUNT_KEY_FLATTENED` (see below)

#### Flattening the service account key

Terraform expects a flattened version of the service account key. See
[these instructions](https://www.haigmail.com/2019/10/07/setting-up-google_credentials-for-terraform-cloud/) for how to
do this.

### Business as usual

Commit and push! Successful CI/CD pipelines will result in a new image, tagged with the commit SHA, being built and
deployed each time, with old images being pruned from the VM.
