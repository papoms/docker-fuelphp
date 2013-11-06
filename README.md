(N.B. the way that Docker handles permissions may vary depending on your current Docker version. If you're getting errors like
```
dial unix /var/run/docker.sock: permission denied
```
when you run the below commands, simply use sudo. This is a [known issue](https://twitter.com/docker/status/366040073793323008).)


This repo contains a recipe for making a [Docker](http://docker.io) container, with Apache, MySQL, PHP and Fuelphp preinstalled.
To build, make sure you have Docker [installed](http://www.docker.io/gettingstarted/), clone this repo somewhere, and then run:

```
docker build -t <yourname>/fuelphp .
```

Then run it! Woo! 
```
docker run -d -p 80 <yourname>/fuelphp
```


Check docker logs after running to see MySQL root password, as so

```
echo $(docker logs <container-id> | sed -n 1p)
```
