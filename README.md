# Fundguard Assignment

This repository is for the Fundguard assignment. It sets up a Kind cluster running Elasticsearch and integrates Prometheus for monitoring. 

## Overview
This project involves the installation of the Elasticsearch Operator, which simplifies the management of Elasticsearch clusters. It utilizes a custom Helm chart to deploy the cluster, along with the Elasticsearch Exporter that connects to the Elasticsearch cluster. Additionally, the project includes the installation of the kube-prometheus-stack, which automatically scrapes metrics from the exporter and provides custom alerts for monitoring. The project also involves the installation of the Istio chart for service mesh capabilities. Furthermore, all Elasticsearch ports except for 9200 are closed for security purposes.

## Requirements
- Kind
- kubectl
- Docker
- Helm

## Installation
1. Run the install script:
   ```bash
   chmod +x scripts/install.sh
   scripts/install.sh
   ```

## Uninstallation
To uninstall, run the uninstall script:

1. Run the uninstall script:
   ```bash
   chmod +x scripts/uninstall.sh
   scripts/uninstall.sh
   ```