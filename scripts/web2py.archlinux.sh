#!/bin/bash
# the script should be run
# from WEB2PY root directory

prog="web2py.py"

chmod +x $prog

function web2py_start {
  nohup python2 ./$prog -a "<recycle>" 2>&1 >>/dev/null &
  pid=`pgrep -f $prog | tail -1`
  if [ "x$pid" != "x$$" ]
  then
    echo "WEB2PY has been started."
  else
    echo "Failed to start WEB2PY."
  fi
}

function web2py_stop {
  kill -15 `pgrep -f $prog | grep -v $$` 2>&1 >>/dev/null
  pid=`pgrep $prog | head -1`
  if [ "x$pid" -ne "x$$" ]
  then
    echo "WEB2PY has been stopped."
  else
    echo "Failed to start WEB2PY."
  fi
}

case "$1" in
  start)
    web2py_start
  ;;
  stop)
    web2py_stop
  ;;
  restart)
    web2py_stop
    web2py_start
  ;;
  *)
    echo "Usage: $0 [start|stop|restart]"
  ;;
esac

exit 0

