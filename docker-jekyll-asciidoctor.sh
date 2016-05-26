#!/bin/bash
SRCDIR=${1-$(pwd)}

docker run --user $(id -u):$(id -g) -p 4000:4000 -it -v $SRCDIR:/work machinekit/jekyll-asciidoctor-base \
       jekyll serve --incremental --host=0.0.0.0 --watch --force_polling
