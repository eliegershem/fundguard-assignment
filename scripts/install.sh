# cluster spinup
kind create cluster --name fundguard

# install es-oprator helm chart
echo installing elastic-operator...
helm install elastic-operator ./charts/eck-operator --namespace elastic-stack --create-namespace

# install elastic-search-cluster helm chart
echo installing elastic-search-cluster...
helm install elastic-search-cluster ./charts/elastic-search-cluster --namespace elastic-stack

# port-forward elastic-search-cluster
echo port-forward elastic-search-cluster to local network...

retry_count=0
max_retries=10
until kubectl port-forward service/elastic-search-cluster-es-http 9200:9200 --namespace elastic-stack; do
    retry_count=$((retry_count + 1))
    if [ $retry_count -ge $max_retries ]; then
        echo "Failed to port-forward after $max_retries attempts."
        exit 1
    fi
    echo "Retrying... ($retry_count/$max_retries)"
    sleep 15
done