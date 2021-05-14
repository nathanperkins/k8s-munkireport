# K8s MunkiReport

This is a very simple test deployment of MunkiReport using K8s. The database is hosted locally using hostPath. This should not be used for anything except educational purposes.

## Deployment Instructions

- [Install kind](https://kind.sigs.k8s.io/docs/user/quick-start/)

- Create a kind cluster.

  ```shell
  kind create cluster --config=kind-cluster.yaml
  ```

- Apply the NGINX ingress controller.

  ```shell
  kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/kind/deploy.yaml
  ```

- Apply manifests.

  ```shell
  kubectl apply --recursive -f manifests/
  ```

- Navigate to [MunkiReport](http://localhost/)
