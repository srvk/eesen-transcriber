#!/bin/bash

sed -i `lscpu -p|grep -v '#'|wc -l|awk '{printf ("s/Procs=DYN/Procs=%d/",$0)}'` /etc/slurm-llnl/slurm.conf
