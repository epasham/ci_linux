#!/bin/bash

exec java -jar ./task-engine-netty.jar --spring.config.location=file:./conf/fix_taskengine.properties,file:./conf/taskengine.properties


