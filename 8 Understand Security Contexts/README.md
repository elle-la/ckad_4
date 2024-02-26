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
cd ckad_4/8\ Understand\ Security\ Contexts/
```

**NOTE:** This will set a very long working directory. If this bothers you, you can tell Linux just to display your current directory without the path by running this command. It will only change your prompt for your current shell session.

```
PS1="\W\$ "
```

## Answers

Answers to each task can be found in the `answers.md` file.

## Tasks

### Task 1

### Task 2

## Clean Up

### Exam Scenarios

```
kubectl delete -f secure-pod.yaml
kubectl delete -f file-svc.yaml
```

### Tasks

```
kubectl delete -f comm-app.yaml
kubectl delete -f db-comm-config.yaml
kubectl delete -f comm-config.yaml
kubectl delete -f message-svc.yaml
kubectl delete -f broker-config.yaml
kubectl delete -f message-config.yaml
```
