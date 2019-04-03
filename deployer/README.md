# Deployer

based on  https://www.lightbend.com/blog/how-to-deploy-kubeflow-on-lightbend-platform-openshift-introduction

## Steps for developerment

```
oc login ...
oc new-project kubeflow
oc create serviceaccount kubeflow-deployer
oc adm policy add-cluster-role-to-user cluster-admin -z kubeflow-deployer
oc create -f DeploymentConfig.yml
```