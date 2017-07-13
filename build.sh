#!/bin/bash

GOPATH=/go
REPO_PATH=$GOPATH/src/github.com/grafana/grafana

cd $REPO_PATH

go run build.go -includeBuildNumber=false build
npm install -g yarn
yarn install

source /etc/profile.d/rvm.sh
rvm use 2.1.9 --default

gem install fpm -v 1.4

go run build.go -includeBuildNumber=false package
