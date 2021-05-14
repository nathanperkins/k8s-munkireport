CLUSTER_NAME?=munkireport
NAMESPACE?=munkireport
TIMEOUT=60s

create:
	cat kind-cluster.yaml.template | envsubst > kind-cluster.yaml
	kind create cluster --name $(CLUSTER_NAME) --config=kind-cluster.yaml
	$(MAKE) apply

apply:
# Apply ingress-nginx controller.
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

# Apply munkireport and mysql.
	kubectl create namespace $(NAMESPACE) --dry-run=client -o yaml | kubectl apply -f -
	kubectl apply --recursive --namespace=$(NAMESPACE) -f manifests/sql/
	kubectl apply --recursive --namespace=$(NAMESPACE) -f manifests/munkireport/
	kubectl wait \
		--for=condition=Available \
		deployment \
		--namespace $(NAMESPACE) \
		--all \
		--timeout=$(TIMEOUT)

# Apply ingress and any leftovers.
	kubectl apply --recursive --namespace=$(NAMESPACE) -f manifests/

destroy:
	kind delete cluster --name $(CLUSTER_NAME)

clean:
	[[ -n $(HOME) ]]
	rm -rf $(HOME)/mysql-data
