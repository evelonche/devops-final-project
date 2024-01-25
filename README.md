# devops-final-project
Final project for the DevOps Upskill course

Kubeflow/KServe + Terraform for ML model serving.

## Overview
```
├── infrastructure
│   ├── kubernetes_resources.tf
│   ├── main.tf
│   ├── terraform.tfstate
│   └── terraform.tfstate.backup
├── README.md
└── training
    ├── mlruns
    ├── requirements.txt
    └── train.py
```
- `infrastructure` directory contains the Terraform code for setting up the infrastructure
- `training` directory contains the Python code for training and registering a model with MLflow and sklearn
# Deploying locally

## Requirements
- Database of choice with an MLflow user with required variables. Defaults values can be seen in variables.tf. Overwrite these by setting the variables in the environment where Terraform is running.
- Enable ingress addon in minikube and map the IP to mlflow-server.local 
