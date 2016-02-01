#!/bin/bash
SRCDIR=${1-$(pwd)}
COMMAND=$2
docker run -i -v $SRCDIR:/var/local/jekyll -t jekyll-asciidoctor $COMMAND
