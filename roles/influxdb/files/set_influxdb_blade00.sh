#!/bin/bash
#
influx -port 58086 -execute 'CREATE DATABASE tsg_stat'
influx -port 58086 -execute 'CREATE RETENTION POLICY "1_day" ON "tsg_stat" DURATION 1d REPLICATION 1 DEFAULT'
