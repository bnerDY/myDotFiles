PID=$(ps -ef | grep node\ spiderMon.js | grep -v grep | awk '{ print $2 }')
if [ -z "$PID" ]
then
    echo spiderMon is already stopped
else
    echo kill $PID
    kill -9 $PID
fi