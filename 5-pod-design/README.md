# Labels , Selectors & Annotations

## Labels
Key-value pairs attacehes to K8s objects.They are used for identified various attributes of objects which can in turn be used to select anf group various subsets of those objects.

We attach labels to objects by annotating them in `metadata.labels`.

To see the labels you can use:
 - `kubectl get pods --show-labels`
 - `kubectl describe pod <pod-name>`

## Selectors

Selectors are used for identifying and selecting a specific group of objects using their labels. 

Three methods to use selectors :
 - *Simple operators* via  `kubectl get <object-type> -l <key>OP<value>`, wher OP can be `==`, `!=` 
 - *Set based*  `-l key in (val1,val2)` 
 - *Chained selectors* via a comma-separated labels  `-l key1=val1, key2=val2`

## Annotations

Similar to labels, used to store custom metadata related to declared objects.
However, unlike labels, annotations cannot be used  to select or group objects in Kubernetes.
External tools can read, write, and interact with annotatoins.

We can attach annotations to objects using `metadata.annotations`.

# Deployments

Deploymets provide a way to declarative manage a dynamic set of replica pods. They provide powerful functionality such as scaling and rolling updates.

**A deployment defines a desired state** for the replica pods. The cluster will constantlu work to maintain that desired state, creating, removing, and modifying the replica pods accordingly.

Three core items in the description of a deployment:

- `spec.replicas` - the desired number of replica pods to deploy and manage
- `spec.template` - which is vey similar to a pod descriptor
- `spec.selector` - the deployment will manage all pods whos labels match this selector

## Rolling updates 

Rolling updates provide a way **to update a deployment to a new container version** by gradually update replicas.

To execute a rolling update, we can use the following command:

```bash
kubectl set image deployment/<deployment-name> <container-name> = <image-name> --record
```

💡 *The `--record` flag records the information about the update so that in can be rolled back later*

## Rollback

To revert to a previous state we can first get a lit of previous updates with `kubectl rollout history`

```bash
kubectl rollout history deployment/<deployment-name>
```

The revision flag will give more information on a specific revision number:

```bash
kubectl rollout history deployment/<deployment-name> --revision <revision-number>
```

To rollback to the last revision use `kubectl rollout undo`:
```bash
kubectl rollout undo deployment/<deployment-name>
```

To rollback to a specific version use `--to-revision` flag:
```bash
kubectl rollout undo deployment/<deployment-name> --to-revision <revision-number>
```

# Jobs and CronJobs

Jobs can be used to reliably execute a workload until completes. The job will create one or more pods. Whenthe job is finished, the container(s) will exit and the pod(s) will enter the completed state.

