#!/bin/bash

#getting last image from GCE
img=$(gcloud compute images list --filter=name:reddit-full --sort-by="~creationTimestamp" --limit=1 | cut -f 1 -d ' ' | grep -v NAME)
#creating vm
gcloud compute instances create "reddit-app" --zone "europe-west3-c" --machine-type "g1-small" --tags "puma-server" --image "$img"

