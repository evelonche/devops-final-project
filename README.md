# devops-final-project
Final project for the DevOps Upskill course.

# Background
This project tries to solve an issue I encountered during my bachelor thesis. I was developing ML models and had to compare the results and performance. The process was predominantly manual, involving extensive use of Excel sheets for results analysis. This approach was not only time-consuming but also prone to errors and inefficiencies.

## Value stream map of BSc. thesis
![ValueStreamMap](https://github.com/evelonche/devops-final-project/assets/14963998/c22c1c41-1c99-480b-b04a-a0f8073cb348)

This is an approximation of how working on my thesis went. The goal was to compare several different models performance for a specific task. The total time available for me to develop and write the thesis was 4 months. According to the Value Stream Map above, for 3 models developed (the amount that were developed in the end), it would take 130 days or 4.33 months. The main bottleneck was tracking the performance of the models, collecting the results and comparing them manually.

# Solution

To address the issue of tracking and preparing models, this project introduces an automated process for ML model training and result tracking on a local Kubernetes cluster. It allows a Python developer to submit their training jobs to the local cluster, track and compare their performance in the MLflow UI. Additionally, a CI pipeline is available for the Python code, which also builds and pushes the Docker container to Dockerhub. 

Topics from the DevOps course which are covered: 
* Value stream mapping
* Source control
* Branching strategies: Trunk-based development
* Building Pipelines
* Continuous Integration
* Security
* Docker
* Kubernetes
* Infrastructure as code
* Secrets management
  
# Overview

- `infrastructure` directory contains the Terraform code for setting up the infrastructure. It assumes that a minikube cluster has been started locally.
  - `main.tf` contains the provider versions
  - `mlflow.tf` contains the resources related to the MLflow tracking server.
  - `postgres.tf` contains the resources related to the Postgres DB which is neede for the tracking server.
  - `variables.tf` contains variables.
- `training` directory contains the Python code for training and registering a model with MLflow and sklearn. Additionally, contains one example manifest for running the example training code.
- `.github/workflows` directory contains 3 different GitActions pipelines:
  - `infrastructure-commit.yaml` is a pipeline which runs whenever changes are made to the /infrastructure directoty. It checks the terraform formatting, lints the Terraform code, validates it and performs a Checkov check
  - `python-commit.yml` is a pipeline which runs whenever changes are made to the `/training` directory or the main `Dockerfile`. It runs black, pylint, gitleaks, SonarCloud, build the Docker image, checks it for vulnerabilities with Trivy and then pushes it to Dockerhub.
  - `mlflow-commit.yml` is a pipeline which runs whenever changes are made to the `mlflow.Dockerfile` or its `requirements.txt`. It builds the Docker image for the MLflow tracking server, checks it for vulnerabilities with Trivy and pushes it to Dockerhub.
  - 
## Requirements
- Minikube cluster running on local machine. Ingress addon of Minikube enabled. Kubectl installed.
- Terraform >= 1.7.0.
- Choose a password for the database and set it as a Terraform variable in the development environment.
  ```
  export TF_VAR_db_password=<password>
  ```

## Installation instructions 
1. Make sure you have everything from 'Requirements' section set up already.
2. From the `infrastructure` repository, run
   ```
   terraform init
   terraform plan
   ```
3. If plan looks good to you, you can run
   ```
   terraform apply
   ```
4. Get the name of the MLflow server pod. It is the one starting with `mlflow-server`. We need this for the next step.
   ```
   kubectl get pods -n mlflow
   ```
5. Forward the port to be able to view the MLflow UI.
   ```
   kubectl port-forward <mlflow-server-pod-name> -n mlflow 5000:5000
   ```
   You can now access the MLflow UI at http://localhost:5000/.
6. Apply the training manifest from `/training` on the mlflow namespace
   ```
   kubectl apply -f ../training/elasticnet_manifest.yml -n mlflow
   ```
   The job will be finished in several seconds, and then you can see the results on the MLflow UI
![Screenshot from 2024-01-28 14-36-55](https://github.com/evelonche/devops-final-project/assets/14963998/5c4c770b-e28b-461a-89c1-042f9de4d115)
