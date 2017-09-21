#!/bin/bash
source ~/.bash_profile
echo "$1 beg time: `date`" >> ../log/cron.log
if [ ! $# == 0 ] && [ $1 == 'stop' ]; then
    pids=`ps -ef | grep xgboost_server | grep py | awk '{print $2}'`
    for pid in $pids
    do
        pid2kills=`ps -ef | grep $pid | grep -v "grep" | awk '{print $2}'`
        for pid2kill in $pid2kills
        do
            kill -9 $pid2kill
        done
    done
    stat=0
else
    python xgboost_server.py >>../log/run.out 2>>../log/run.err&
    stat=$?
fi
echo "$1 end time: `date` stat: $stat" >> ../log/cron.log
exit $stat
