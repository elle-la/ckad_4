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
cd ckad_4/3\ Understand\ Authentication\ Authorization\ and\ Admission\ Control/
```

**NOTE:** This will set a very long working directory. If this bothers you, you can tell Linux just to display your current directory without the path by running this command. It will only change your prompt for your current shell session.

```
PS1="\W\$ "
```

Create the namespace:

```
kubectl create namespace ps-dev
```

## Answers

Answers to each task can be found in the `answers.md` file.

## Tasks

### Task 1

Create a role named `readonly-config-secrets` that grants read-only access to `ConfigMaps` and `Secrets` in the `ps-dev` namespace. Assign this role to the `developers` group.

### Task 2

Update the cluster role, `node-maintenance`, which enables monitoring and managing Nodes across the entire cluster, so that it  accomplishes this objective.

Apply the role to the `cluster-ops` group.

### Task 3

You are tasked with enhancing the security posture of your Kubernetes cluster. Your goal is to ensure that all deployed Pods meet specific security standards, such as running as a non-root user and having an immutable root filesystem.

Enable the appropriate admission controller to enforce these Pod Security Standards cluster-wide. Then, deploy the `secure-namespace.yaml` file from the working directory.

## Clean Up

### Exam Scenarios

```
kubectl delete -f admin-role.yaml
kubectl delete -f admin-rb.yaml
```

If desired, remove the admission controller from `/etc/kubernetes/manifests/kube-apiserver.yaml`.

### Tasks

```
kubectl delete -f secrets-role.yaml
kubectl delete -f secrets-rb.yaml
kubectl delete -f node-maintenance.yaml
kubectl delete -f node-maintenance-rb.yaml
kubectl delete -f secure-namespace.yaml
```

If desired, remove the admission controller from `/etc/kubernetes/manifests/kube-apiserver.yaml`.
