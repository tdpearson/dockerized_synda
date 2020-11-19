# Dockerized synda
[synda](http://prodiguer.github.io/synda/) is a command line tool to search and download files from the Earth System Grid Federation ([ESGF](http://pcmdi.llnl.gov/)) archive.

This project wraps synda into a Docker container to create a repeatable install.

## Requirements
* Docker
* Docker Compose
* GNU Make

## Setup
* Run the following commands to download and setup
  ```
  $ make build
  $ make copy_configs
  ```
* Edit `./conf/credentials.conf`

## Install selection files
* Create desired selection files within `./selections/`
* Install selections by replacing "/sample/sample_selection_01.txt" with your desired selection file
  ```
  $ selection=/sample/sample_selection_01.txt make install_selection
  ```

## Start selection downloads / synda daemon
* Start synda's daemon process by running
  ```
  $ make run
  ```
* Check daemon is connecting
  ```
  $ tail -f ./log/transfer.log
  ```

## Stopping synda daemo
* Run the following to stop the Dockerized daemon process
  ```
  $ make stop
  ```

## Running one-off synda commands
```
$ docker-compose run --rm synda synda [command]
```

## TODO
1. New files are saved with root ownership. Update to have the host user own these files.
