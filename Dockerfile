FROM ubuntu:15.10

MAINTAINER Marc Schumacher "docker@marc-schumacher.de"

from ubuntu:precise

RUN apt-get -y update && apt-get install -y \
    curl \
    build-essential \
    nodejs \
    npm && \
    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 && \
    curl -L https://get.rvm.io | bash -s stable

ENV PATH /usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN /usr/local/rvm/bin/rvm-shell && rvm requirements && rvm install 2.3.0 && rvm use 2.3.0 --default

ENV PATH /usr/local/rvm/rubies/ruby-2.3.0/bin:/usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN gem install \
    jekyll \
    asciidoctor \
    jekyll-asciidoc \
    tilt \
    haml \
    slim \
    thread_safe \
    asciidoctor-diagram \
    coderay \
    pygments.rb \
    jekyll-paginate && \
    gem install --pre asciidoctor-pdf 

WORKDIR /var/local/jekyll
