#!/bin/bash
service dse start
nohup datastax-studio-1.0.0/bin/server.sh > datastax-studio-1.0.0/server.log 2>&1 &
/bin/bash
