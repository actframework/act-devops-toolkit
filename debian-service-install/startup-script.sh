#!/bin/sh
### BEGIN INIT INFO
# Provides:          SERVICENAME
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start SERVICENAME at boot time
# Description:       Enable ACT.FRAMEWORK service provided by SERVICENAME.
### END INIT INFO

#
# Startup script for the Act service install on Debian
#
# chkconfig: - 85 15
# processname: SERVICENAME

# Set Tomcat environment.
ACT_USER=SERVICENAME
LOCKFILE=/var/lock/SERVICENAME
export PATH=/usr/local/bin:$PATH
export ACT_HOME=SERVICEPATH
export ACT_PID=$ACT_HOME/SERVICENAME.pid
export ACT_OPTS="-D -Djava.awt.headless=true"

# Source function library.
. /lib/lsb/init-functions

[ -f $ACT_HOME/start ] || exit 0

export PATH=$PATH:/usr/bin:/usr/local/bin

# See how we were called.
case "$1" in
  start)
        # Start daemon.
        echo -n "Starting ACT Framework Service : SERVICENAME"
        su -p -s /bin/sh $ACT_USER -c "cd $ACT_HOME && ./start -Dpidfile=$ACT_PID"
        RETVAL=$?
        echo
        [ $RETVAL = 0 ] && touch $LOCKFILE
        ;;
  stop)
        # Stop daemons.
        echo -n "Shutting down ACT Framework Service : SERVICENAME"
        su -p -s /bin/sh $ACT_USER -c "kill -9 `cat $ACT_PID`"
        RETVAL=$?
        echo
        [ $RETVAL = 0 ] && rm -f $LOCKFILE
        ;;
  restart)
        $0 stop
        $0 start
        ;;
  status)
        status -p $ACT_PID -l $(basename $LOCKFILE) SERVICENAME
        ;;
  *)
        echo "Usage: $0 {start|stop|restart|status}"
        exit 1
esac

exit 0
