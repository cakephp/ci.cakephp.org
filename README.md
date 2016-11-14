# CI

A Dokku-deployable Jenkins server, preconfigured with a number of plugins and access to running Docker commands.

# Deploying

On the Dokku server:

```shell
# create requisite persistent storage
mkdir -p /var/lib/dokku/data/storage/ci
chown 32767:32767 /var/lib/dokku/data/storage/ci

# create the app
dokku apps:create ci

# mount the storage, docker socket, and docker binary
dokku storage:mount ci /var/lib/dokku/data/storage/ci:/var/jenkins_home
dokku storage:mount ci /var/run/docker.sock:/var/run/docker.sock
dokku storage:mount ci /usr/bin/docker:/usr/bin/docker

# ensure we expose to the right port
dokku proxy:ports-add ci http:80:8080
```

On your local computer:

```shell
# add the remote
git remote add dokku dokku@SERVER_IP:ci

# push the app
git push dokku master
```
