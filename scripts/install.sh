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

# port-forward elastic-search-cluster
echo port-forward elastic-search-cluster to local network...

retry_count=0
max_retries=10
until kubectl port-forward service/elastic-search-cluster-es-http 9200:9200 -n elastic-stack; do
    retry_count=$((retry_count + 1))
    if [ $retry_count -ge $max_retries ]; then
        echo "Failed to port-forward after $max_retries attempts."
        exit 1
    fi
    echo "Retrying... ($retry_count/$max_retries)"
    sleep 15
done