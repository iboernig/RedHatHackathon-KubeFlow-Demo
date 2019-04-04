# RedHatHackathon-KubeFlow-Demo
Red Hat Hackathon 2019 - KubeFlow Demo

## Kubeflow deployment

based on  https://www.lightbend.com/blog/how-to-deploy-kubeflow-on-lightbend-platform-openshift-introduction

### Steps for development

```
oc login ...
oc new-project <your-namespace>
oc create serviceaccount kubeflow-deployer
oc adm policy add-cluster-role-to-user cluster-admin -z kubeflow-deployer
# Run deployer & workbox pod to deploy kubeflow
oc create -f https://raw.githubusercontent.com/rbo/RedHatHackathon-KubeFlow-Demo/master/deployer/ksonnet-workbox.yml
```


#### Follow the logs
```
oc logs -f -c kubeflow-deploy $(oc get pods -o name -l deploymentconfig=workbox)
```

#### Login into workbox
```
oc rsh $(oc get pods -o name -l deploymentconfig=workbox)
cd /workspace/openshift/ks_app
ks...
```


## Demo

please follow 
- https://www.lightbend.com/blog/how-to-deploy-kubeflow-on-lightbend-platform-openshift-introduction
- https://github.com/kubeflow/examples/tree/master/github_issue_summarization


