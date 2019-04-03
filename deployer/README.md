# Deployer

based on  https://www.lightbend.com/blog/how-to-deploy-kubeflow-on-lightbend-platform-openshift-introduction

## Steps for development

```
oc login ...
oc new-project <your-namespace>
oc create serviceaccount kubeflow-deployer
oc adm policy add-cluster-role-to-user cluster-admin -z kubeflow-deployer
# Run deployer & workbox pod to deploy kubeflow
oc create -f ksonnet-workbox.yml

# Follow the logs
oc logs -f -c kubeflow-deploy workbox-.....

```
