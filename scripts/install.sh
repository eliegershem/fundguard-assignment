# cluster spinup
kind create cluster --name fundguard

# install es-oprator helm chart
echo installing elastic-operator...
helm install elastic-operator ./charts/eck-operator -n elastic-stack --create-namespace

# install kube-prometheus-stack helm chart
echo installing kube-prometheus-stack...
helm install prometheus ./charts/kube-prometheus-stack -n monitoring --create-namespace

# install prometheus-elasticsearch-exporter helm chart
echo installing prometheus-elasticsearch-exporter...
helm install prometheus-elasticsearch-exporter ./charts/prometheus-elasticsearch-exporter -n elastic-stack -f ./values/prometheus-elasticsearch-exporter/values.yaml

# install elastic-search-cluster helm chart
echo installing elastic-search-cluster...
helm install elastic-search-cluster ./charts/elastic-search-cluster -n elastic-stack