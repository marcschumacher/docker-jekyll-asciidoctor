FROM ubuntu:15.10

MAINTAINER Marc Schumacher "docker@marc-schumacher.de"

from ubuntu:precise

RUN apt-get -y update && apt-get install -y \
    curl \
    build-essential \
    nodejs \
    npm

RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

RUN curl -L https://get.rvm.io | bash -s stable

ENV PATH /usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN /usr/local/rvm/bin/rvm-shell && rvm requirements
RUN /usr/local/rvm/bin/rvm-shell && rvm install 2.3.0
RUN /usr/local/rvm/bin/rvm-shell && rvm use 2.3.0 --default

ENV PATH /usr/local/rvm/rubies/ruby-2.3.0/bin:/usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN gem install jekyll 

RUN gem install asciidoctor jekyll-asciidoc tilt haml slim thread_safe 

RUN gem install asciidoctor-diagram coderay pygments.rb

RUN gem install --pre asciidoctor-pdf 

RUN gem install jekyll-paginate

WORKDIR /var/local/jekyll
