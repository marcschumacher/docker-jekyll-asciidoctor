# docker-jekyll-asciidoctor

This docker image is ready to build and serve jekyll sites. It is used to format the machinekit.io website.

Beyond [jekyll-asciidoctor](https://github.com/asciidoctor/jekyll-asciidoc), this image includes all tools supported by the [asciidoctor-diagram](https://github.com/asciidoctor/asciidoctor-diagram) plugin.

build as:
````
  cd jekyll-asciidoctor-base
  docker build -t machinekit/jekyll-asciidoctor-base .
````

format and serve the site on port 4000 like so:
````
  ./docker-jekyll-asciidoctor.sh [jekyll site directory]
````

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

To build such a custom image, review, edit and run [gen-user-img.sh script](https://github.com/mhaberler/docker-jekyll-asciidoctor/blob/master/jekyll-asciidoctor-custom/gen-user-img.sh).


