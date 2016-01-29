# docker-jekyll-asciidoctor

With this docker image you have a prepared system to build jekyll sites.

To build this image, `cd` to the checked out git repo and use the following 
docker command to build it: `docker build -t jekyll-asciidoctor .`

Use the following docker command to run jekyll. Specify the folder which shall 
be used as working directory. This shall usually be the folder containing 
your jekyll directory: 
`docker run -i -v $(pwd):/var/local/jekyll -t jekyll-asciidoctor jekyll build`.