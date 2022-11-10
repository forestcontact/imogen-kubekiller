#!/bin/bash
mkdir ~/.kube
echo $KUBE_CREDENTIALS|base64 -d > ~/.kube/config
cron -f
