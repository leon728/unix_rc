#!/bin/sh
mib2c -i -c mib2c.bba.conf $1:$2
#sed "s/$3/$4/" mib_$2_tbl.c > mib_$3_tbl.tmp
sed -i "s/890,1,5,13,13/COMPANY_MODEL_OID/" mib_$2_tbl.c
