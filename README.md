# K8s MunkiReport

This is a very simple test deployment of MunkiReport using K8s. The database is
hosted locally using hostPath. This should not be used for anything except
educational purposes.

## Deployment Instructions

1. [Install kind](https://kind.sigs.k8s.io/docs/user/quick-start/).

1. Create cluster with nginx ingress and MunkiReport.

    ```shell
    make create
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
