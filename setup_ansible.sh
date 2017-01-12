#!/bin/bash


# Install ansible

  apt-get update
  apt-get install -y git python-dev python-pip python-openssl
  pip install --upgrade pip
  pip install -U setuptools
  pip install ansible
