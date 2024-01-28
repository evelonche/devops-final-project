# devops-final-project
Final project for the DevOps Upskill course.

# Background
This project tries to solve an issue I encountered during my bachelor thesis. I was developing ML models and had to compare the results and performance. The process was predominantly manual, involving extensive use of Excel sheets for results analysis. This approach was not only time-consuming but also prone to errors and inefficiencies.

# Solution

To address this issue, this project introduces an automated process for ML model training and result tracking on a local Kubernetes cluster. It allows a Python developer to submit their training jobs to the local cluster, track and compare their performance in the MLflow UI. Additionally, a CI pipeline is available for the Python code, which also builds and pushes the Docker container to Dockerhub. 

Topics from the DevOps course which are covered: 
* Source control: This repository
* Branching strategies: I have chosen trunk-based development because of the quick feedback loop and having fewer branches to manage, as the only developer for this project.
* Building Pipelines
* Continuous Integration
* Security
* Docker - For running the MLflow tracking server, as well as ML training jobs. 
* Kubernetes - All resources are running on a local Kubernetes cluster. 
* Infrastructure as code - Terraform is used to create all resources for the MLflow tracking server. 
* Configuration management
* Secrets management
  
# Overview

- `infrastructure` directory contains the Terraform code for setting up the infrastructure
- `training` directory contains the Python code for training and registering a model with MLflow and sklearn
# Deploying locally

## Requirements
- Database of choice with an MLflow user with required variables. Defaults values can be seen in variables.tf. Overwrite these by setting the variables in the environment where Terraform is running.
- Enable ingress addon in minikube and map the IP to mlflow-server.local 
