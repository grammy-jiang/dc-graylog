# Docker Compose of Graylog

A very simple docker-compose of Graylog.

# How to use this `docker-compose.yml`

## Start the service, show the log message and check the status

### Create the local environment files

Copy `graylog.env.example`:

```console
foo@bar:~$ cp graylog.env.example graylog.env
```

Then edit it to fit your local development usage.

### Start the service

Once the service is started by `docker-compose`, `docker-compose` will supervise the
status of the service:
* if the service is down for any reasons, `dockerc-compose` will try to restart it,
  because `restart` option is set to `always` in `docker-compose.yml`
* if the computer shuts down without running `docker-compose down` command,
  `docker-compose` will restart the service when the computer restart

```console
foo@bar:~$ docker-compose up --detach
Creating network "dc-graylog_nw-graylog" with driver "bridge"
Creating dc-graylog-mongo         ... done
Creating dc-graylog-elasticsearch ... done
Creating dc-graylog               ... done
```

### Read the log messages
```console
foo@bar:~$ docker-compose logs --follow
...
```

### Check the status

```console
foo@bar:~$ docker-compose ps
          Name                        Command                       State                                            Ports
------------------------------------------------------------------------------------------------------------------------------------------------------------
dc-graylog                 tini -- /docker-entrypoint ...   Up (health: starting)   0.0.0.0:12201->12201/tcp, 0.0.0.0:1514->1514/tcp, 0.0.0.0:9000->9000/tcp
dc-graylog-elasticsearch   /usr/local/bin/docker-entr ...   Up                      9200/tcp, 9300/tcp
dc-graylog-mongo           docker-entrypoint.sh mongod      Up                      27017/tcp
```

## Stop the service and remove the data

### Stop the service

Once the service is stopped by the command `docker-compose down`, it will totally
shutdown and `docker-compose` will not supervise it or restart it in any circumstances.

```console
foo@bar:~$ docker-compose down --volumes
Stopping dc-graylog               ... done
Stopping dc-graylog-elasticsearch ... done
Stopping dc-graylog-mongo         ... done
Removing dc-graylog               ... done
Removing dc-graylog-elasticsearch ... done
Removing dc-graylog-mongo         ... done
Removing network dc-graylog_nw-graylog
```

### Remove the volumes

These volumes contains the service content. This `docker-compose.yml` will mount them
at the beginning. Once they are deleted, the previous content is gone, and the service
will create new, empty volumes at the beginning.

```console
foo@bar:~$ sudo rm -rf mongo-data
```

# Reference

* [mongo - Docker Hub](https://hub.docker.com/_/mongo)
* [Install Elasticsearch with Docker | Elasticsearch Reference [7.10] | Elastic](https://www.elastic.co/guide/en/elasticsearch/reference/current/docker.html)
  * [Docker @ Elastic](https://www.docker.elastic.co/)
  * [elasticsearch - Docker Hub](https://hub.docker.com/_/elasticsearch)
  * [elasticsearch/distribution/docker at master · elastic/elasticsearch](https://github.com/elastic/elasticsearch/tree/master/distribution/docker)
* [Industry Leading Log Management | Graylog](https://www.graylog.org/)
  * [Welcome to the Graylog documentation — Graylog 4.0.0 documentation](https://docs.graylog.org/en/4.0/)
    * [Docker — Graylog 4.0.0 documentation](https://docs.graylog.org/en/4.0/pages/installation/docker.html)
