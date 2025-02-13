#!/bin/bash
set -x

# cluster spinup
kind create cluster --name fundguard

# install istio helm charts
helm install istio-base ./charts/istio-base -n istio-system --create-namespace
helm install istiod ./charts/istiod -n istio-system

# install es-oprator helm chart
helm install elastic-operator ./charts/eck-operator -n elastic-stack --create-namespace
kubectl label namespace elastic-system istio-injection=enabled

# install kube-prometheus-stack helm chart
helm install prometheus ./charts/kube-prometheus-stack -n monitoring --create-namespace

# install prometheus-elasticsearch-exporter helm chart
helm install prometheus-elasticsearch-exporter ./charts/prometheus-elasticsearch-exporter -n elastic-stack -f ./values/prometheus-elasticsearch-exporter/values.yaml

# install elastic-search-cluster helm chart
helm install elastic-search-cluster ./charts/elastic-search-cluster -n elastic-stack