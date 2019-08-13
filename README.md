# CI

A Dokku-deployable Jenkins server, preconfigured with a number of plugins and access to running Docker commands.

# Deploying

On the Dokku server:

```shell
# create the app
dokku apps:create ci

# create requisite persistent storage
mkdir -p /var/lib/dokku/data/storage/ci
chown 1000:1000 /var/lib/dokku/data/storage/ci

# add extra system packages
dokku config:set ci SYSTEM_PACKAGES=build-essential,sudo

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

# Dumping `plugins.txt`

```groovy
List<String> jenkinsPlugins = new ArrayList<String>(Jenkins.instance.pluginManager.plugins);
jenkinsPlugins.sort { it.displayName }
              .each { plugin ->
                   println ("${plugin.shortName}:${plugin.version}")
              }
```
