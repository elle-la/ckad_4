# Answers

## Task 1

Create a role named `readonly-config-secrets` that grants read-only access to `ConfigMaps` and `Secrets` in the `ps-dev` namespace. Assign this role to the `developers` group.

### Answer

Create the role:

```
vim secret-role.yaml
```

Populate the file with a role object meeting the needed definitions:

```
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  namespace: ps-dev
  name: readonly-config-secrets
rules:
- apiGroups: [""]
  resources: ["configmaps", "secrets"]
  verbs: ["get", "list", "watch"]
```

Save and exit. Deploy the role:

```
kubectl apply -f secret-role.yaml
```

Open a new file, `secret-rb.yaml`:

```
vim secret-rb.yaml
```

Create a role-binding definition mapping the `developers` group to the new role:

```
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: bind-readonly-config-secrets
  namespace: ps-dev
subjects:
- kind: Group
  name: developers
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role
  name: readonly-config-secrets
  apiGroup: rbac.authorization.k8s.io
```

Save and exit; deploy:

```
kubectl apply -f secret-rb.yaml
```

Confirm by running:

```
kubectl get roles
kubectl get rolebindings
```

## Task 2

Update the cluster role, `node-maintenance`, which enables monitoring and managing Nodes across the entire cluster, so that it  accomplishes this objective.

Apply the role to the `cluster-ops` group.

### Answer

Open `node-maintenance.yaml`:

```
vim node-maintenance.yaml
```

Update the definition to include `update` and `patch` actions:

```
rules:
- apiGroups: [""]
  resources: ["nodes"]
  verbs: ["get", "list", "watch", "update", "patch"]
```

Save and exit. Redeploy the role:

```
kubectl apply -f node-maintenance.yaml
```

Create a new file:

```
vim node-maintenance-rb.yaml
```

Create a cluster role-binding definition mapping the new role to the `cluster-ops` group:

```
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: node-maintenance-rb
subjects:
- kind: Group
  name: cluster-ops
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: ClusterRole
  name: node-maintenance-role
  apiGroup: rbac.authorization.k8s.io
```

Save and exit.

Deploy the rolebinding:

```
kubectl apply -f node-maintenance-rb.yaml
```

Confirm by running:

```
kubectl get roles
kubectl get rolebindings
```

## Task 3

You are tasked with enhancing the security posture of your Kubernetes cluster. Your goal is to ensure that all deployed Pods meet specific security standards, such as running as a non-root user and having an immutable root filesystem.

Enable the appropriate admission controller to enforce these Pod Security Standards cluster-wide. Then, deploy the `secure-namespace.yaml` file from the working directory.

### Answer

Update the Kubernetes API server so the admission controller is enabled:

```
sudo vim /etc/kubernetes/manifests/kube-apiserver.yaml
```

```
...
--enable-admission-plugins=PodSecurity
...
```

Wait for the Kubernetes server to restart.

Deploy the `secure-namespace.yaml` pod:

```
kubectl apply -f secure-namespace.yaml
```
