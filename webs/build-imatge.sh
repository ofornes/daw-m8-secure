#!/bin/bash

docker build --file assets/dockerfiles/python3-dockerfile --no-cache -t dawm8-python3:latest -t dawm8-python3:0.0.1 .
