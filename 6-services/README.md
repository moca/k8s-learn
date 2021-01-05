# Services

> Services create an abstraction layer which provides network access to a dynamic set of pods.

***Most services use a selector to determine which pods will receive traffic.***

As pods are created and removed dynamically, clients can receive uninterrupted access by using an abstracion layer object : the service.

Some of the key items when defined a service are:

- `type` - Which specifies how to expose the service. To make the service only reachable at the cluster level we may want to use the  `ClusterIP` . For expose to the external world you may use the `LoadBalancer` type.
- `selector` - the labels of the pods that the service will expose.
- `port` - Specifies the port under which the service will listen on.
- `targetPort` - Specifies the port that traffic will be forwarded to the pods. We can ommit this param if port and target port have the same values.

To see all running services :
```bash
kubectl get svc
```

To see the endpoints of a service :
```bash
kubectl get endpoints [<service-name>]
```

## Services Types

This are the most common types of service types : 

- **`ClusterIP`** exposes the service within the cluster using an internal IP address. The service is also accesible using the Cluster DNS.
- **`NodePort`**  the service is exposed externally via a port which listens on each node in the cluster.
- `LoadBalancer` this only works with cloud providers. The service is exposed trough a load balancer that is created on the cloud platform.
- `ExternalName` This maps the service to an external address. It is used to allow resouces within the cluster to access things outside the cluster trough a service. **This only sets up a DNS mapping. I does not proxy traffic.**

# Network Policies

By default, all pods in the cluster can communicate with any other pod, and reach out to any available IP.

NetworkPolicies allow you to limit what network traffic is allowed to and from pods in the cluster.

To add network policies, we need to add a plugin to our K8s cluster : Calico

To know more about calico see : https://docs.projectcalico.org/getting-started/kubernetes/

## Installing Calico

In order to use calico on top of flannel simply follow the instructions provided in the following link : 
https://docs.projectcalico.org/getting-started/kubernetes/flannel/flannel

## Policies Description

Some of the key description elements:

- `podSelector` - Determines which pods the NetworkPolicy applies to.
- `policyTypes` - Sets whether the policy governs incoming traffic (ingress), outgoing traffic (egrress) or both.
- `ingress` - rules for incoming traffic  
- `egress` - rules for outgoing traffic
  - `ports` - specifies the protocol and ports that match the rules
  - `from/to`  selectors - specifies the source(s) and destination(s) of network traffic that matches the rule.  

### Selectors

From/to selectors are used to specify which traffci source(s) and destination(s) are allowed to the rule. There are  different type of selectors:

- **podSelector**: Matches the traffic from/to pods with match the selector
- **namespaceSelector**: Matches the  traffic from/to pods within namespaces which match the selector. Note that when podSelector and namespaceSelector are both present the matching pods must also be within a matching namespace.
- **ipBlock** : Specified a CIDR range of IPs that will match the rule. This is mostly used for traffic from/to outside the cluster.
