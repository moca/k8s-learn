# Multi-containers Pod Interaction

How can containers can communicate with one another in a pod ?

Three posibilities.

**Shared Network**
All listening ports are accessible to other containerd in the pod, even if they are not expoded outside the pod.
We can safely use localhost to connect.

**Shared Storage Volumes**
Container can interact with each toher by reading and modifying giles in a shared storage volume that is mounted in both containers.

**Shared Process Namespace**
With process namespace sharing enabled, containers in the same pod can interact with and signal one another's processeses.

To enbale process namespace add ``shareProcessNamespace:true`` in the pod spec.

# Design patterns for multi-containers pods

## Sidecar Pod
Enhances or add the fonctionality of the main container in someway.

## Ambassador Container
The ambassador container captures all network traffic before pass it on to the main container. E.g. Do port forwarding.

## Adapter Pod
The adapter container change the output of the main container in some way. E.g. changes the log format of the main container.

