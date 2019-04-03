# Deployer

based on  https://www.lightbend.com/blog/how-to-deploy-kubeflow-on-lightbend-platform-openshift-introduction

## Steps for developerment

```
oc login ...
oc new-project kubeflow
oc create serviceaccount kubeflow-deployer
oc adm policy add-cluster-role-to-user cluster-admin -z kubeflow-deployer
# Run deployer pod to deploy kubeflow
oc create -f deployer-pod.yml

# If you need a ksonnet workbox:
oc create -f ksonnet-workbox.yml
```