# Answers

## Task 1

A new application pod, `api-pod` is being deployed in your Kubernetes cluster. It needs to adhere to strict security policies including:

- Running as a specific user ID 2000 and group ID 3000
- Preventing any escalation of privileges
- The application needs to communicate on port 9443, which typically requires elevated privileges. Ensure it has the capability to bind to this port by adding the `CAP_NET_BIND_SERVICE` capability

### Answer

Review the provided task, making note of each security context. Specially, you want to add: `runAsUser`, `runAsGroup`, `capabilities`, and `allowPrivilegeEscalation` settings.

The structure of this security context might resemble:

```
securityContext:
  runAsUser: 2000
  runAsGroup: 3000
  capabilities:
    add:
      - CAP_NET_BIND_SERVICE
  allowPrivilegeEscalation: false
```

Open and update `api-pod.yaml` so that the security contexts are under the _container_ spec:

```
vim api-pod.yaml
```

```
apiVersion: v1
kind: Pod
metadata:
  name: api-pod
spec:
  containers:
  - name: busybox
    image: busybox:stable
    command: ['sh', '-c', 'while true; do echo Running...; sleep 5; done']
    securityContext:
      runAsUser: 2000
      runAsGroup: 3000
      capabilities:
        add:
          - CAP_NET_BIND_SERVICE
      allowPrivilegeEscalation: false
```

Save and exit. Launch the pod:

```
kubectl apply -f api-pod.yaml
```

## Task 2

The `cache-pod` is designed to cache data for applications, necessitating specific security contexts. The requirements include:

- The pod should run under user ID 4050 and group ID 4050.
- It must include a security context to forbid the use of the SYS_TIME capability
- The volume mount should allow the pod to write data, but ensure the root filesystem remains read-only 

### Answer

Consider the task and pod definition, considering what security contexts you might need to add. For this task we will need the `runAsUser`, `runAsGroup`, `capabilities`, and `readOnlyRootFilesystem` values. Your context block should resemble:

```
securityContext:
  runAsUser: 4050
  runAsGroup: 4050
  capabilities:
    drop:
      - SYS_TIME
  readOnlyRootFilesystem: true
```

Open the `cache-pod.yaml` file and add the context to the container specification. Note that the reference to "volume mount" indicates we should work in the container spec:

```
vim cache-pod.yaml
```

```
apiVersion: v1
kind: Pod
metadata:
  name: cache-pod
spec:
  containers:
  - name: busybox
    image: busybox:stable
    command: ['sh', '-c', 'while true; do echo Running...; sleep 5; done']
    securityContext:
      runAsUser: 4050
      runAsGroup: 4050
      capabilities:
        drop:
          - SYS_TIME
      readOnlyRootFilesystem: true
    volumeMounts:
    - mountPath: /var/cache
      name: cache-volume
  volumes:
    - name: cache-volume
      emptyDir: {}
```

Save and exit. Launch the pod:

```
kubectl apply -f cache-pod.yaml
```
