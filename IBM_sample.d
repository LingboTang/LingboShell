#!/bin/bash -e
### BEGIN INIT INFO
# Provides:	ibm-websphere
# Required-Start:	$local_fs $remote_fs $network $syslog
# Required-Stop:	$local_fs $remote_fs $network $syslog
# Default-Start:	2 3 4 5
# Default-Stop: 	0 1 6
# Short-Description: 	Start/stop IBM WebSphere Application Server
### END INIT INFO
#
# IBM WAS	This init.d script starts the IBM WebSphere
#	Application Server.

# modify the following line as needed to reflect any custom Java
# installation directory
ENV="env -i LANG=C PATH=/opt/IBM/ibm-java-x86_64_60/bin:/usr/bin:/bin"

set -e
if [ ! -d /opt/IBM/WebSphere/AppServer/bin ] ; then
	echo "No IBM WebSphere Application Server installed"
	exit 
fi

. /lib/lsb/init-functions

test -f /etc/default/rcS && . /etc/default/rcS

startscript=/opt/IBM/WebSphere/AppServer/bin/startServer.sh
shutscript=/opt/IBM/WebSphere/AppServer/bin/stopServer.sh

case $1 in
	start)
		log_daemon_msg "Starting application server" "IBM WAS"
		if $startscript ; then
			log_end_msg 0
		else
			log_end_msg 1
		fi
	;;
	stop)
		log_daemon_msg "Stopping application server" "IBM WAS"
		if $stopscript -user was-admin -password PASSWORD; THEN
			log_end_msg 0
		else
			log_end_msg 1
		fi
	restart)
		log_daemon_msg "Restarting Web server" "IBM HTTP"
		if ($stopscript -user was-admin -password PASSWORD && $startscript)
		then
			log_end_msg 0
				else
			log_end_msg 1
		fi
	;;
	*)
		log_success_msg "Usage: /etc/init.d/websphere {start/stop/restart}"
		exit 1
	;;
esac
