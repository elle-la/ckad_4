# Answers

## Task 1

A pod defined in `unstable-pod.yaml` is experiencing frequent restarts with a CrashLoopBackOff status. Initial analysis suggests the pod is being terminated due to exceeding its memory limit. The current memory limit is set to 100 MiB, but monitoring tools indicate usage occasionally spikes to 150 MiB. Adjust the pod definition to prevent these restarts.

### Answer

Open `unstable-pod.yaml`:

```
vim unstable-pod.yaml
```

Notice the `memory`, under `limit`. It is currently set to `100Gi`. Assuming that the data given to us that it maxes out at `150` is correct, adjust this limit:

```
      limits:
        cpu: "200m"
        memory: "150Gi"
```

Save and exit the file.

Deploy the pod, if desired:

```
kubectl apply -f unstable-pod.yaml
```

## Task 2

Attempt to deploy the pod defined in `lightweight-svc.yaml`. Troubleshoot the pod definition.

### Answer

Attempt to deploy the pod:

```
kubectl apply -f lightweight-svc.yaml
```

Notice the error; specifically:

```
resources.requests: Invalid value: "2Gi": must be less than or equal to memory limit of 10Mi
```

Open `lightweight-svc.yaml`:

```
vim lightweight-svc.yaml
```

Update the `memory` request so it reads `2Mi`:

```
    resources:
      requests:
        cpu: "10m"
        memory: "2Mi"
```

Save and exit. Deploy:

```
kubectl apply -f lightweight-svc.yaml
```

## Task 3

Create a namespace, `ps-test`, that limits the total amount of storage that can be requested to 100Gi. Ensure that no single PersistentVolumeClaim can request more than 10Gi.

### Answer

Create the namespace:

```
kubectl create namespace ps-test
```

Create the resource quota file:

```
vim ps-test-quota.yaml
```

Configure the quotas using `persistentvolumeclaims` and `requests.storage` parameters.

```
apiVersion: v1
kind: ResourceQuota
metadata:
  name: ps-test-quota
  namespace: ps-test
spec:
  hard:
    persistentvolumeclaims: "10"
    requests.storage: "100Gi"
```

Save and exit. Deploy the quota:

```
kubectl apply -f ps-test-quota.yaml
```
