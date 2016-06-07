#!/bin/bash

curl -i \
     -d slaveId="0c2ccdca-98e8-466e-ad2c-e6aeccea6548-S1" \
           -d resources='[
           {
           "role": "kafka-role",
           "reservation": {  },
            "name" : "disk",
            "type" : "SCALAR",
            "scalar" : { "value" : 777 },
            "disk" : {
              "source" : {
                "type" : "MOUNT",
                "mount" : { "root" : "/dcos/volume0" }
              }
            }
           }
     ]' \
     -X POST http://m1.dcos/mesos/master/reserve
