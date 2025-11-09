#!/usr/bin/env bash


echo master IP=$1
sudo mkdir data
# sudo mkdir upload
sudo chown postgres data



sudo chown postgres *.conf
cp *.conf data
grep listen data/postgres.conf

pg_ctl -D data -l /dev/null start

psql -c 'CREATE EXTENSION citus'

pg_ctl -D data -l /dev/null stop
postgres -D data 
