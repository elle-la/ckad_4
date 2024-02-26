# Answers

## Task 1

The `deploy-manager` deployment needs permissions to create, update, and delete deployments in the `deployments` namespace. Set up the necessary access using the `deployment-manager` role.

You may need to create the needed namespace:

```
kubectl create namespace deployments
```

### Answer

Review the provided `deploy-manager.yaml` and `deployment-manager-role.yaml` files before preceding. To apply this role to the pod definition, you will need to create a service account, and then map that account to the role with the a rolebinding. The service account will also need to be mapped to the pod definition.

Begin by create the service account:

```
vim deploy-manager-sa.yaml
```

```
apiVersion: v1
kind: ServiceAccount
metadata:
  name: deploy-manager-sa
  namespace: deployments
```

Save and exit. Use `kubectl` to apply the YAML:

```
kubectl apply -f deploy-manager-sa.yaml
```

Next, create a rolebinding, in which the newly-created service account is bound to the existing `deployment-manager-role`.

```
vim deploy-manager-rb.yaml
```

```
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: deploy-manager-rb
  namespace: deployments
subjects:
- kind: ServiceAccount
  name: deploy-manager-sa
  namespace: deployments
roleRef:
  kind: Role
  name: deployment-manager-role
  apiGroup: rbac.authorization.k8s.io
```

Save and exit the file. Apply:

```
kubectl apply -f deploy-manager-rb.yaml
```

Finally, update the pod definition to reference the newly-created service account:

```
vim deploy-manager.yaml
```

```
...
spec:
  replicas: 1
  selector:
    matchLabels:
      app: deploy-manager
  template:
    metadata:
      labels:
        app: deploy-manager
    spec:
      serviceAccountName: deploy-manager-sa
...
```

Save and exit. Deploy:

```
kubectl apply -f deploy-manager.yaml
```

## Task 2

The `custom-metrics-collector` pod needs the ability to list and watch custom metrics across the cluster. Perform the needed actions for the pod to accomplish this.

### Answer

Only the pod definition is available for this task, so you will need to create all components to create a service account to map it, including creating the role and rolebinding.

Begin by creating the service account:

```
vim custom-metrics-sa.yaml
```

```
apiVersion: v1
kind: ServiceAccount
metadata:
  name: custom-metrics-sa
```

Save and exit. Apply to create the account:

```
kubectl apply -f custom-metrics-sa.yaml
```

Next, create the role--notice that the task requests that it works _cluster-wide_, so we need a CluserRole:

```
vim metrics-viewer-role.yaml
```

```
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: metrics-viewer-role
rules:
- apiGroups: [""]
  resources: ["*"]
  verbs: ["get", "list", "watch"]
```

Save and exit the file. Create the role:

```
kubectl apply -f metrics-viewer-role.yaml
```

Next, bind the service account to the role with a rolebinding:

```
vim custom-metrics-crb.yaml
```

```
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: custom-metrics-viewer-crb
subjects:
- kind: ServiceAccount
  name: custom-metrics-sa
  namespace: default
roleRef:
  kind: ClusterRole
  name: metrics-viewer-role
  apiGroup: rbac.authorization.k8s.io
```

Save and exit. Create the rolebinding:

```
kubectl apply -f custom-metrics-crb.yaml
```

Finally, update the pod definition to use the service account:

```
vim custom-metrics-collector.yaml
```

```
  serviceAccountName: custom-metrics-sa
```

Save, exit, and deploy:

```
kubectl apply -f custom-metrics-collector.yaml
```
