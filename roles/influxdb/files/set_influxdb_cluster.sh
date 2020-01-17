#!/bin/bash
#

influx -port 58086 -execute 'CREATE RETENTION POLICY "1_year" ON "tsg_stat" DURATION 365d REPLICATION 1 DEFAULT'
