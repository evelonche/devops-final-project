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
- `training` directory contains the Python code for training and registering a model with MLflow and sklearn. Additionally, contains one example manifest for running the example training code.
- 
## Requirements
- Minikube cluster running on local machine. Ingress addon of Minikube enabled.
- Terraform versions as specified in the `infrastructure/main.tf`.

## Project structure
The `infrastructure` directory contains all Terraform code for creating the MLflow and cluster resources on the local minikube cluster. 
The `training` directory contains example ML training code, the requirements for it and a Kubernetes manifest to train the model on the cluster. 

## Installation instructions 
