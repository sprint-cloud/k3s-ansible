#!/bin/bash
NODE_NAME="${1:-staging-k3s-cplane-1}"
MON_TYPE="${2:-policy-verdict}"
CILIUM_NAMESPACE=kube-system
CILIUM_POD_NAME=$(kubectl -n $CILIUM_NAMESPACE get pods -l "k8s-app=cilium" -o jsonpath="{.items[?(@.spec.nodeName=='$NODE_NAME')].metadata.name}")
kubectl -n $CILIUM_NAMESPACE exec $CILIUM_POD_NAME -- \
  cilium endpoint list
kubectl -n $CILIUM_NAMESPACE exec $CILIUM_POD_NAME -- \
  cilium monitor -t $MON_TYPE
