FROM ubuntu:15.10

MAINTAINER Marc Schumacher "docker@marc-schumacher.de"

RUN apt-get -y update && apt-get install -y \
    curl \
    build-essential \
    nodejs \
    npm \
    git && \
    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 && \
    curl -L https://get.rvm.io | bash -s stable

ENV PATH /usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN /usr/local/rvm/bin/rvm-shell && rvm requirements && rvm install 2.3.0 && rvm use 2.3.0 --default

ENV PATH /usr/local/rvm/rubies/ruby-2.3.0/bin:/usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

ADD Gemfile /root/
ADD config /root/.ssh/
RUN chown root.root /root/.ssh/config && chmod 600 /root/.ssh/config

RUN cd /root/ && gem install bundler

RUN cd /root/ && bundle install

# RUN gem install \
#     jekyll \
#     asciidoctor \
#     jekyll-asciidoc \
#     tilt \
#     haml \
#     slim \
#     thread_safe \
#     asciidoctor-diagram \
#     coderay \
#     pygments.rb \
#     jekyll-paginate \
#     redcarpet \
#     jekyll-twitter-plugin \
#     jekyll-email-protect && \
#     gem install --pre asciidoctor-pdf 

WORKDIR /var/local/jekyll
