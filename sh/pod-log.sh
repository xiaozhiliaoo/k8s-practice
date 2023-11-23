#!/usr/bin/env bash


if [ "$1" != "" ] && [ "$2" != "" ] ; then
    kubectl logs -n $1 -f --tail=200 `kubectl get pods -n $1 | grep $2 | awk '{print $1}' | awk 'NR==1'`
else
    usage
fi

