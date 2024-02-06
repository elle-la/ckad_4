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
cd ckad_4/4\ Understand\ and\ Define\ Resource\ Requirements\ Limits\ and\ Quotas
```

**NOTE:** This will set a very long working directory. If this bothers you, you can tell Linux just to display your current directory without the path by running this command. It will only change your prompt for your current shell session.

```
PS1="\W\$ "
```

## Answers

Answers to each task can be found in the `answers.md` file.

## Tasks

### Task 1

A pod defined in `unstable-pod.yaml` is experiencing frequent restarts with a CrashLoopBackOff status. Initial analysis suggests the pod is being terminated due to exceeding its memory limit. The current memory limit is set to 100 MiB, but monitoring tools indicate usage occasionally spikes to 150 MiB. Adjust the pod definition to prevent these restarts.

### Task 2

Attempt to deploy the pod defined in `lightweight-svc.yaml`. Troubleshoot the pod definition.

### Task 3

Create a namespace, `ps-test`, that limits the total amount of storage that can be requested to 100Gi. Ensure that no single PersistentVolumeClaim can request more than 10Gi.

## Clean Up

### Exam Scenarios

```
kubectl delete -f pod-svc.yaml
kubectl delete -f ps-sandbox-quota.yaml
kubectl delete -f big-pod.yaml
```

### Tasks

```
kubectl delete -f unstable-pod.yaml
kubectl delete -f lightweight-svc.yaml
kubectl delete -f ps-test-quota.yaml
```
