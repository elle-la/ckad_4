# Test yourself tasks

Complete the following tasks in your own time.

## Restrictions

The following restrictions will help emulate exam conditions.

- Only use approved websites (`kubernetes.io/docs`, `kubernetes.io/blog`, `github.com/kubernetes` and `helm.sh`)
- Use only your chosen product's man pages and other documentation installed by your products (E.g. `buildah --help`, `docker --help`, `podman --help`)
- Do not refer to any other notes
- Do not make any hand-written notes

The full list of exam requirements and restrictions can be found [here](https://docs.linuxfoundation.org/tc-docs/certification/lf-handbook2/exam-rules-and-policies).

## Prerequisites

The images and containers you'll work with are all Linux-based. It's recommended to test yourself in a Linux-based environment. This is because the exam environment is Linux-based.

If you haven't already done so, clone the repo with the following command.

```
git clone https://github.com/elle-la/ckad_4.git
```

Run the following command to change into the correct directory. The tasks expect your terminal to be in this directory. If it isn't, the answers won't work.

```
cd ckad_4/5\ Understand\ ConfigMaps
```

**NOTE:** This will set a very long working directory. If this bothers you, you can tell Linux just to display your current directory without the path by running this command. It will only change your prompt for your current shell session.

```
PS1="\W\$ "
```

## Answers

Answers to each task can be found in the `answers.md` file.

## Tasks

### Task 1

The `ps-api.yaml` pod requires access to the APIs notes below, which need to be supplied to the container as the defined environmental variables. These values will also be used by other containers. Perform the needed actions to provide these variables to the container.

```
WEATHER_API = https://weather.pluralsight.com/v2
STORMWARN_API = https://swarn.pluralsight.com/v1
```

### Task 2

A backend application, `backend.yaml`, requires a configuration file to set up its logging and database connection information excluding passwords. This configuration should include:

```
LOG_LEVEL = info
DB_HOST = db-service
DB_PORT = 5432
```

Create the necessary Kubernetes object to store these configuration settings for use in the application.

### Task 3

A custom logging service, `logger.yaml`, deployed on Kubernetes relies on environment variables to adjust its behavior and output formatting. It requires:

```
LOG_FORMAT = json
BUFFER_SIZE = 512
```

Additionally, the content of `logging-init.sh` should be supplied to the `/tmp/logging-init.sh` location on the container.

Compose the Kubernetes ConfigMap that holds these configuration values for the logging service.

## Clean Up

### Exam Scenarios

```
kubectl delete -f nginx_app.yaml
kubectl delete -f nginx_map.yaml
kubectl delete -f demo-dev.yaml
kubectl delete -f demo-dev-config.yaml
```

### Tasks

```
kubectl delete -f ps-api.yaml
kubectl delete -f api-map.yaml
kubectl delete -f backend.yaml
kubectl delete -f backend-map.yaml
kubectl delete -f logger.yaml
kubectl delete -f logger-map.yaml
```
