#!/bin/bash

#Exit the script if any statement returns a non-true value
set -e

cd ~/

git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install
puma -d