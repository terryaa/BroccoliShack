#!/bin/bash

flume-ng agent --conf conf --conf-file /home/hadoop/flume/conf/final_project.flume --name a1 -Dflume.root.logger=INFO,console
