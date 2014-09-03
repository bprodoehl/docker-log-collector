#!/bin/bash

docker stop collector
docker stop kibana
docker stop elasticsearch

docker rm collector
docker rm kibana
docker rm elasticsearch
