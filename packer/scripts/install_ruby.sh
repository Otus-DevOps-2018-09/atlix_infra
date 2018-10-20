#!/bin/bash

#Exit the script if any statement returns a non-true value
set -e

apt update 
apt install -y ruby-full ruby-bundler build-essential
