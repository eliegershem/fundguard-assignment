# cluster spinup
kind create cluster --name fundguard

# install es-oprator helm chart
helm install elastic-operator ./charts/eck-operator --namespace elastic-stack --create-namespace

# install elastic-search-cluster helm chart
helm install elastic-search-cluster ./charts/elastic-search-cluster --namespace elastic-stack

# print out elastic-search-cluster url
ELASTIC_SEARCH_URL=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' fundguard-control-plane):3000
echo $ELASTIC_SEARCH_URL