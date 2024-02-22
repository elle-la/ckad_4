# Answers

## Task 1

Configure the `comm-app` deployment to securely handle database credentials and dynamically manage application settings. The application must connect to a database for processing transactions and adjust its behavior based on feature flags and operational parameters.

Database credentials:

```
Username = SGloaWhlbGxvCg==
Password = dGhpc2lzbXlwYXNzd29yZAo=
```

Application configuration:

```
Feature Flag (New Checkout Flow) = enabled
Maximum Transaction Value: = 5000
Log Level = INFO
```

### Answers

Review the provided information and consider what needs to be stored as secrets and what should be configuration maps. Additionally, review the `comm-app.yaml` deployment to see what variable names the application expects.

The database credentials should be stored as secrets; they are already encoded. Create a Secrets object for these secrets:

```
vim db-comm-config.yaml
```

```
apiVersion: v1
kind: Secret
metadata:
  name: db-comm-config
type: Opaque
data:
  USERNAME: "SGloaWhlbGxvCg=="
  PASSWORD: "dGhpc2lzbXlwYXNzd29yZAo="
```

Save and exit. Create the secret object:

```
kubectl apply -f db-comm-config.yaml
```

Create a ConfigMap definition for the rest of the configuration values:

```
vim comm-config.yaml
```

```
apiVersion: v1
kind: ConfigMap
metadata:
  name: comm-config
data:
  NEW_CHECKOUT_FLOW: "enabled"
  MAX_TRANSACTION_VALUE: "5000"
  LOG_LEVEL: "INFO"
```

Save, exit, and deploy:

```
kubectl apply -f comm-config.yaml
```

Update the `comm-app.yaml` file to use these new definitions:

```
vim comm-app.yaml
```

```
...
    spec:
      restartPolicy: Never
      containers:
      - name: busybox
        image: busybox:stable
        command: ['sh', '-c', 'echo $USERNAME; echo $PASSWORD; echo $NEW_CHECKOUT_FLOW; echo $MAX_TRANSACTION_VALUE; echo $LOG_LEVEL']
        envFrom:
          - secretRef:
              name: db-comm-config
          - configMapRef:
              name: comm-config
```

Save and exit. Launch the deployment:

```
kubectl apply -f comm-app.yaml
kubectl logs deployment.apps/comm-app
```

The logs should contain the provided secret and configuration mapping information.

### Task 2

Configure the `message-svc.yaml` deployment to securely handle authentication credentials for connecting to a message broker and dynamically manage service parameters through environment variables.

Broker creds:

```
Username = YnJva2VydXNlcm5hbWUK
Password = YnJva2VycGFzc3dvcmQK
```

Service config:

```
Message Queue Name = orders
Retry Attempts = 5
Logging Level = WARN
```

### Answers

Review the provided content and determine what should be stored as a secret and what should be stored as a configuration mapping. Review the `message-svc.yaml` file to discover desired variable names.

Store the broker data as a secret object:

```
vim broker-config.yaml
```

```
apiVersion: v1
kind: Secret
metadata:
  name: broker-config
type: Opaque
data:
  USERNAME: "YnJva2VydXNlcm5hbWUK"
  PASSWORD: "YnJva2VycGFzc3dvcmQK"
```

Save, exit, and create:

```
kubectl apply -f broker-config.yaml
```

Store the remaining variables in a ConfigMap object:

```
vim message-config.yaml
```

```
apiVersion: v1
kind: ConfigMap
metadata:
  name: message-config
data:
  MESSAGE_QUEUE_NAME: "orders"
  RETRY_ATTEMPTS: "5"
  LOG_LEVEL: "WARN"
```

Save, exit, and create:

```
kubectl apply -f message-config.yaml
```

Update `message-svc.yaml` to use the stored configurations:

```
vim message.svc.yaml
```

```
...
    spec:
      containers:
      - name: busybox
        image: busybox:stable
        command: ['sh', '-c', 'echo $USERNAME; echo $PASSWORD; echo $MESSAGE_QUEUE_NAME; echo $RETRY_ATTEMPTS; echo $LOG_LEVEL']
        envFrom:
          - secretRef:
              name: broker-config
          - configMapRef:
              name: message-config
```

Save, exit, and deploy:

```
kubectl apply -f message-svc.yaml
```

Check the logs to determine if your variables are working:

```
kubectl logs deployment.apps/message-svc
```
