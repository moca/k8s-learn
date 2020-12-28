# Volumes

The internal storage of a container is ephemeral.
*Volumes allow you to provide more permanent storage to a pod that exists beyond the life of a container*

It exists multiple types of volumes. One of the simplest is `EmptyDir`. 

`EmptyDir` volumes create storage on a node when the pod is assignes to the node. The storage dissapears when the pod leaves the node.

# State Persistence

Kubernetes is designed to manage stateless containers. Pods and containers can be easilu deleted and/or replaces. When a container is removed, data stored indie the container's internal disk is lost.

**State persistence refers to maintaining data outside and potentilly beyond the life of a container.**

Kubernetes allows us to implement persistent storage using `PersistenVolumes`  and `PersistentVolumeClaims`.

`PersistenVolumes`  or PV  - represents a storage resource.

`PersistentVolumeClaims` or PVC - abstraction layer between user (pod) and the PV. PVC will automcatically bind themselves to a PV that has compatible `StorageClass` and `accessModes`.



