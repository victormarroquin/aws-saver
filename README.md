# aws-saver
A simple bash script to start and stop instances using tags, scheludable with cron to automate the start/stop process

## Features:

- Save money on aws stoping your non production instances.
- Check it if the selected instances are running or not.

## Limitations:

Limited to linux, tested on ubuntu only.

## Prerequisites:

Have installed the aws command line (CLI). If you don't have it go to [Installing the AWS Command Line Interface](http://docs.aws.amazon.com/cli/latest/userguide/installing.html)

Have taged the desired instances with a specific tag.

## Usage:

To use in the easy way you can place the bash on usr/local/bin.

if you prefer use other location, you can add on /etc/environment/ file on PATH variable the custom location.

saver {tag_name} {tag_value} list | status | start | stop.

### list

Display the instances with the specified tag.

### status

Display the status (stop or running) of the instances with the specified tag.

### start

Start (power on) the instances matching with ths specified tag.

### stop

Stop (power off) the instances matching with ths specified tag.

## Using cron

In order to automate the process you could use cron.
```
50 3 * * * {saver_path}/saver {tag_name} {tag_value} {action}
```
Example:
```
50 3 * * * /opt/tools/aws-saver/saver Saver Enable stop
0 12 * * * /opt/tools/aws-saver/saver Saver Enable start
```
