# Liveness and readiness probes

- **Probes** : Allows you to customize how kubernetes determines the status of your containers
- **Liveness probe** : Indicates whether the container is running properly and governs when the cluster will automatically stop or restart the container. *Healthy test.*
- **Readiness Probe** : Indicates whether the container is ready to service requests, and governs whether requests will be forwarded to the pod. *Readiness tests*

Liveness an readiness probes can determine container status by doing like running a command or making an http request.

# Container Logging
A containers normal console output goes into the container log. You can access the container logs using the `kubectl logs` command.

If a pod has more than one container, you must specify from which container to get logs using the `-C` flag. e.g. `kubectl logs a-pod -C a-container`

# Metrics Server

The K8s metric server provides an API which allow you to access data about your pods and nodes, such as CPU and memory usage.

## Installing the metrics server
```bash
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
```

Test that the metrics server is working:
```bash
kubectl get --raw "/apis/metrics.k8s.io/v1beta1/nodes"
```

If not working, you may have to take a look at the logs of the metrics server. You may have issues concerning tls, if so change the deployment of the metrics server as follows:

```yaml
command:
    - /metrics-server 
    - --kubelet-preferred-address-types=InternalIP
    - --kubelet-insecure-tls
```

## Monitoring Applications and Nodes
With a working metrics server we can use the `kubectl top` to gather information about resource usage within the cluster.

- `kubectl top pods`
- `kubectl top pods <pod-name>` for a single pod
- `kubectl top pods -n <namespace>` in a different namespace
- `kubectl top nodes` for different nodes


# Debugging

Relevant documentation: 
- https://kubernetes.io/docs/tasks/debug-application-cluster/debug-application/
- https://kubernetes.io/docs/tasks/debug-application-cluster/debug-pod-replication-controller/
- https://kubernetes.io/docs/tasks/debug-application-cluster/debug-service/

## Finding the problem

- `kubectl get <object-name>` to get the list of objects
- `--all-namespaces` to list objects from all namespaces
- `kubectl describe` to get the info of an object
- `kubectl get pod [-n <namespace>] <pod-name>  -o json` to get the same level of information of describe in a json format. Useful for exporting.
- `kubectl logs <pod-name> [-c <container-name>]` to get the logs of a running container

## Solving the problem

- `kubecetl edit <object-type> <object-name>` edits specs in the ddefault editor.
- `kubectl get <object-type> <object-name> -o yaml --export` , get a clean yaml definition that you can edit. This is useful if you need to delete, modify and then re-create objects. ⚠️ *Export does not keep the namespace*
- `kubectl apply -f <filename or folder>` .