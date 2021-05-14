# K8s MunkiReport

This is a very simple and experimental deployment of MunkiReport using
Kubernetes. The database is hosted locally with a volume using hostPath. This
should not be used for anything except as a demonstration of some basic K8s
deployment and configuration.

## Deployment Instructions

1. [Install kind](https://kind.sigs.k8s.io/docs/user/quick-start/).

1. Create cluster with nginx ingress and MunkiReport. Note: this step may fail
with an error from the nginx ingress web admission hook. If so, perform the next
step as well to re-deploy the manifests.

    ```shell
    make create
    ```

1. If you make changes to the manifests, you can apply them without re-creating the cluster.

    ```shell
    make apply
    ```

1. [Visit your MunkiReport app](http://munkireport.localhost/).

1. Destroy cluster.

    ```shell
    make destroy
    ```

1. Delete database data.

    ```shell
    make clean
    ```
