# Answers

## Task 1

The `ps-api.yaml` pod requires access to the APIs notes below, which need to be supplied to the container as the defined environmental variables. These values will also be used by other containers. Perform the needed actions to provide these variables to the container.

```
WEATHER_API = https://weather.pluralsight.com/v2
STORMWARN_API = https://swarn.pluralsight.com/v1
```

### Answer

Create a ConfigMap object to store the needed API values:

```
vim api-map.yaml
```

```
apiVersion: v1
kind: ConfigMap
metadata:
  name: api-map
data:
  WEATHER_API: "https://weather.pluralsight.com/v2"
  STORMWARN_API: "https://swarn.pluralsight.com/v1"
```

Save and exit. Deploy the ConfigMap:

```
kubectl apply -f api-map.yaml
```

Update the `ps-api.yaml` definition to add environmental variables:

```
vim ps-api.yaml
```

```
spec:
  restartPolicy: Never
  containers:
    - name: busybox
      image: busybox:stable
      command: ['sh', '-c', 'echo $WEATHER_API; echo $STORMWARN_API']
      envFrom:
      - configMapRef:
          name: api-map
```

Save and exit. Deploy:

```
kubectl apply -f ps-api.yaml
```

You can confirm by running:

```
kubectl logs ps-api
```

The environmental variables should populate the logs if done successfully.

## Task 2

A backend application, `backend.yaml`, requires a configuration file to set up its logging and database connection information excluding passwords. This configuration should include:

```
LOG_LEVEL = info
DB_HOST = db-service
DB_PORT = 5432
```

Create the necessary Kubernetes object to store these configuration settings for use in the application.

### Answer

Create a ConfigMap to store the needed variables for the container:

```
vim backend-map.yaml
```

```
apiVersion: v1
kind: ConfigMap
metadata:
  name: backend-map
data:
  LOG_LEVEL: "info"
  DB_HOST: "db-service"
  DB_PORT: "5432"
```

Save and exit. Create the map:

```
kubectl apply -f backend-map.yaml
```

Update the `backend.yaml` definition to reference the new ConfigMap:

```
vim backend.yaml
```

```
apiVersion: v1
kind: Pod
metadata:
  name: ps-backend
spec:
  restartPolicy: Never
  containers:
    - name: busybox
      image: busybox:stable
      command: ['sh', '-c', 'echo $LOG_LEVEL; echo $DB_HOST; echo $DB_PORT']
      envFrom:
      - configMapRef:
          name: backend-map
```

To confirm, run:

```
kubectl apply -f backend.yaml
kubectl logs backend
```

The logs should output the environmental variables if successful.

## Task 3

A custom logging service, `logger.yaml`, deployed on Kubernetes relies on environment variables to adjust its behavior and output formatting. It requires:

```
LOG_FORMAT = json
BUFFER_SIZE = 512
```

Additionally, the content of `logging-init.sh` should be supplied to the `/tmp/logging-init.sh` location on the container.

Compose the Kubernetes ConfigMap that holds these configuration values for the logging service.

### Answer

Create the ConfigMap based on the provided variables and file content:

```
vim logger-map.yaml
```

```
apiVersion: v1
kind: ConfigMap
metadata:
  name: logger-map
data:
  LOG_FORMAT: "json"
  BUFFER_SIZE: "512"
  logging-init.sh: |
    #!/bin/bash
    mkdir -p /var/log/logging-service
    chmod 755 /var/log/logging-service
    touch /var/log/logging-service/service.log
    chmod 644 /var/log/logging-service/service.log
    echo "$(date) - Logging Service Initialization Complete." >> /var/log/logging-service/service.log
```

Apply the definition:

```
kubectl apply -f logger-map.yaml
```

Open the `logger.yaml` file to reference the variables within the environment, while also adding the `logging-init.sh` content as a file to the container:

```
vim logger.yaml
```

```
apiVersion: v1
kind: Pod
metadata:
  name: ps-logger
spec:
  restartPolicy: Never
  containers:
    - name: busybox
      image: busybox:stable
      command: ['sh', '-c', 'echo $LOG_FORMAT; echo $BUFFER_SIZE; cat /tmp/logging-init.sh']
      env:
        - name: LOG_FORMAT
          valueFrom:
            configMapKeyRef:
              name: logger-map
              key: LOG_FORMAT
        - name: BUFFER_SIZE
          valueFrom:
            configMapKeyRef:
              name: logger-map
              key: BUFFER_SIZE
      volumeMounts:
        - name: script-volume
          mountPath: /tmp/logging-init.sh
          subPath: logging-init.sh
  volumes:
    - name: script-volume
      configMap:
        name: logger-map
        items:
        - key: logging-init.sh
          path: logging-init.sh
```
