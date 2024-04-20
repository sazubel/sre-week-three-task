#!/bin/bash

namespace="sre"
pod="swype-app"
restart=3

#infinite loop
while :
do
  #take the current number of restart of the pod
  num_restart=$(kubectl get pods -n ${namespace} -l app=${pod} -o jsonpath="{.items[0].status.containerStatuses[0].restartCount}")
  if ((num_restart > restart )); then
    echo "${num_restart} is more than ${restart} downscaling the pod..."
    kubectl scale --replicas=0 deployment/${pod} -n ${namespace}
    break
  fi
  echo "restart less than ${restart}, no problem"
  sleep 60
done