# Answers

The following lists each question and associated answer.

## Task 1

Develop a CRD for a logging service, `loggingservice`, that can be deployed across various namespaces to manage log retention policies. This CRD should include fields for `logRetentionDays` (number of days to retain logs) and `logLevel` (`info`, `warn`, `error`).

### Answer

Using your preferred and exam-available text editor (the example uses vim), create a file, `loggingservice.yaml`.

```
vim loggingservice.yaml
```

Add the appropriate API and object definition:

```
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
```

Develop the naming schema of the CRD, being sure to reference the plural name in the metadata name. Ensure the `scope` is `Cluster`, so it works across namespaces:

```
metadata:
  name: loggingservices.pluralsight.com
spec:
  group: pluralsight.com
  scope: Cluster
  names:
    plural: loggingservices
    singular: loggingservice
    kind: LoggingService
    shortNames:
      - ls
```

Further build out the specification by adding a version definition and schema, matching the provided description:

```
  versions:
    - name: v1
      served: true
      storage: true
      schema:
        openAPIV3Schema:
          type: object
          properties:
            spec:
              type: object
              properties:
                logRetentionDays:
                  type: integer
                logLevel:
                  type: string
                  enum: ["info", "warn", "error"]
```

The entire file should resemble:

```
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  name: loggingservices.pluralsight.com
spec:
  group: pluralsight.com
  scope: Namespaced
  names:
    plural: loggingservices
    singular: loggingservice
    kind: LoggingService
    shortNames:
      - ls
  versions:
    - name: v1
      served: true
      storage: true
      schema:
        openAPIV3Schema:
          type: object
          properties:
            spec:
              type: object
              properties:
                logRetentionDays:
                  type: integer
                logLevel:
                  type: string
                  enum: ["info", "warn", "error"]
```

Save the file.

Deploy the CRD:

```
kubectl apply -f loggingservice.yaml
```

Confirm the CRD was deployed with by deploying the `my-service.yaml` file:

```
kubectl apply -f my-service.yaml
```

Further confirm by retrieving the resource information:

```
kubectl get loggingservices
```

## Task 2

Implement a CRD for an auto-scaling service, `autoscaler`, that dynamically adjusts the number of pods based on CPU and memory usage. The CRD should define thresholds for `cpuThresholdPercent` and `memoryThresholdPercent`, above which the service will scale up.

### Answer

Create a new file, `autoscalers.yaml`:

```
vim autoscalers.yaml
```

Populate the file with a custom resource definition, including names, and version schema:

```
vim autoscaler.yaml

apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  name: autoscalers.pluralsight.com
spec:
  group: pluralsight.com
  scope: Namespaced
  names:
    plural: autoscalers
    singular: autoscaler
    kind: AutoScaler
    shortNames:
      - as
  versions:
    - name: v1
      served: true
      storage: true
      schema:
        openAPIV3Schema:
          type: object
          properties:
            spec:
              type: object
              properties:
                cpuThresholdPercent:
                  type: integer
                memoryThresholdPercent:
                  type: integer
```

Save and exit the file.

Deploy the CRD:

```
kubectl apply -f autoscalers.yaml
```

Run the `my-autoscaler.yaml` file and ensure it deploys:

```
kubectl apply -f my-autoscaler.yaml
kubectl get as
```
