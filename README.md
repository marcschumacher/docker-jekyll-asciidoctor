# docker-jekyll-asciidoctor

This docker image is ready to build and serve jekyll sites. It is used to format the machinekit.io website.

Beyond [jekyll-asciidoctor](https://github.com/asciidoctor/jekyll-asciidoc), this image includes all tools supported by the [asciidoctor-diagram](https://github.com/asciidoctor/asciidoctor-diagram) plugin.

build as:
````
  cd jekyll-asciidoctor-base
  docker build -t haberlerm/docker-jekyll-asciidoctor .
````

This base image is also built automatically on dockerhub: https://hub.docker.com/r/haberlerm/docker-jekyll-asciidoctor/~/dockerfile/
hence can be obtained by

````
  docker pull haberlerm/docker-jekyll-asciidoctor
````

To locally format and serve a site, see this gist: https://gist.github.com/mhaberler/ede68eae275c38a5364734c065a1b9c0

# Custom image variant for jenkins use

Just for formatting and serving the site for local editing the jekyll-asciidoctor-base image is sufficient.

However, deploying via git from within a Docker image run by Jenkins is rather tricky, which is why there is jekyll-asciidoctor-custom. You need this only if deploying from jenkins via git push.

This is what I found:
- for push via ssh git url to work, there must be a valid user on the image - with /etc/passwd entry, home directory and all
- its user id and group id should match the Jenkins uid/gid
- the Jenkins uid/gid will vary between installations so the only solution I found was to prepare a per-Jenkins-master docker image with matching id's and run this on master
- the Jenkins SH Agent plugin is used to supply the passphrase to unlock the private key
- the directory containing the private key and the ssh `config` file is mounted as /home/$user/.ssh

````
Host github.com
  HostName github.com
  User <github user id>
  StrictHostKeyChecking=no
  UserKnownHostsFile=/dev/null
  IdentityFile /home/jenkins/.ssh/<name of private key>
````
Such a custom image is used to format _and_ deploy the machinekit.io website to github.

To build such a custom image, review, edit and run [gen-user-img.sh script](https://github.com/mhaberler/docker-jekyll-asciidoctor/blob/master/jekyll-asciidoctor-custom/gen-user-img.sh).


