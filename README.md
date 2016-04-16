# aws-saver
A simple bash script to start and stop instances using tags, scheludable with cron to automate the start/stop process

Features:

Save money on aws stoping your non production instances.
Check it if the selected instances are running or not.

Prerequisits:

Have installed the aws command line (CLI).
Have taged the desired instances with a specific tag.

Usage:

To use in the easy way you can place the bash on usr/local/bin.

if you prefer use other location, you can add on /etc/environment/ file on PATH variable the custom location.

saver {tag_name} {tag_value} list|status|start|stop.
