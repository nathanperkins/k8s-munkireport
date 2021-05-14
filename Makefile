CLUSTER_NAME?=munkireport
NAMESPACE?=munkireport
TIMEOUT=60s

deploy:
	cat kind-cluster.yaml.template | envsubst > kind-cluster.yaml
	kind create cluster --name $(CLUSTER_NAME) --config=kind-cluster.yaml
	kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/kind/deploy.yaml
	kubectl wait \
		--for=condition=Ready \
		node \
		--all \
		--timeout=$(TIMEOUT)
	kubectl wait \
		--for=condition=Available \
		deployment \
		--namespace ingress-nginx \
		--all \
		--timeout=$(TIMEOUT)
	kubectl wait \
		--for=condition=Ready \
		pod \
		--namespace ingress-nginx \
		--selector=app.kubernetes.io/component=controller \
		--timeout=$(TIMEOUT)

	kubectl create namespace $(NAMESPACE)
	kubectl apply --recursive --namespace=$(NAMESPACE) -f manifests/
	kubectl wait \
		--for=condition=Available \
		deployment \
		--namespace $(NAMESPACE) \
		--all \
		--timeout=$(TIMEOUT)

destroy:
	kind delete cluster --name $(CLUSTER_NAME)
