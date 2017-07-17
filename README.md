# nginx-official
Official NGINX docker image adapted for use with Raspberry Pi

### Assumptions
* home for docker build images is ***/srv/docker***
* patch is installed on the host system

To build the docker image run ***/srv/docker/nginx-official/build.sh***
```
mkdir -p /srv/docker
cd /srv/docker
git clone https://github.com/whw3/nginx-official.git
cd nginx-official
chmod 0700 build.sh
./build.sh 
```
