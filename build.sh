#/bin/bash

# Always remove and refresh
[[ -d  /srv/docker/nginx-official/docker-nginx ]] &&  \
  rm -rf /srv/docker/nginx-official/docker-nginx

cd /srv/docker/nginx-official/
git clone https://github.com/nginxinc/docker-nginx.git
patch -p0 < docker-nginx.patch

if [[ "$(docker images -q whw3/alpine 2> /dev/null)" == "" ]]; then
    if [[ ! -d /srv/docker/alpine ]]; then
        cd /srv/docker/
        git clone https://github.com/whw3/alpine.git
    fi
    cd /srv/docker/alpine
    git pull
    /srv/docker/alpine/build.sh
fi
cd /srv/docker/nginx-official/docker-nginx/mainline/alpine/
grep NGINX_VERSION Dockerfile| grep ENV| sed -e 's/ENV/export/;s/$/"/;s/VERSION /VERSION="/' > /srv/docker/nginx-official/NGINX_VERSION
source /srv/docker/nginx-official/NGINX_VERSION
RELEASE=$(echo $NGINX_VERSION | sed 's/\.[0-9]\+$//')
cat << EOF > options 
export RELEASE="v$RELEASE"
export TAGS=(whw3/nginx:$RELEASE whw3/nginx:latest)
EOF

docker build -t whw3/nginx .
