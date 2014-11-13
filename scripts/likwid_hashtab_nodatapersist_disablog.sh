#!/bin/sh
HOMEDIR=/home/sudarsun/libs/linux-examples
DATADIR=/mnt/pmfs
NVMDIR=$NVMALLOC_HOME/scripts

sudo sync
sudo sh -c "echo 3 > /proc/sys/vm/drop_caches"
sudo sync

cd ../
sed -i 's/\-D_NODATAPERSIST/\-D_ENABL_DATAPERSIST/' trivial/Makefile
sed -i 's/\-D_NODATAPERSIST/\-D_ENABL_DATAPERSIST/' icount/Makefile
sed -i 's/\-D_NODATAPERSIST/\-D_ENABL_DATAPERSIST/' libpmemalloc/Makefile
sed -i 's/\-D_NODATAPERSIST/\-D_ENABL_DATAPERSIST/' libpmem/Makefile
sed -i 's/\-D_NODATAPERSIST/\-D_ENABL_DATAPERSIST/' Makefile
sed -i 's/\-D_NODATAPERSIST/\-D_ENABL_DATAPERSIST/' util/Makefile
sed -i 's/\-D_NODATAPERSIST/\-D_ENABL_DATAPERSIST/' binarytree/Makefile
sed -i 's/\-D_NODATAPERSIST/\-D_ENABL_DATAPERSIST/' basic/Makefile
sed -i 's/\-D_NODATAPERSIST/\-D_ENABL_DATAPERSIST/' Makefile.inc

#this will enable logging
sed -i 's/_DISABLE_LOG/_ENABLE_LOG/' trivial/Makefile
sed -i 's/_DISABLE_LOG/_ENABLE_LOG/' icount/Makefile
sed -i 's/_DISABLE_LOG/_ENABLE_LOG/' libpmemalloc/Makefile
sed -i 's/_DISABLE_LOG/_ENABLE_LOG/' libpmem/Makefile
sed -i 's/_DISABLE_LOG/_ENABLE_LOG/' Makefile
sed -i 's/_DISABLE_LOG/_ENABLE_LOG/' util/Makefile
sed -i 's/_DISABLE_LOG/_ENABLE_LOG/' binarytree/Makefile
sed -i 's/_DISABLE_LOG/_ENABLE_LOG/' basic/Makefile
sed -i 's/_DISABLE_LOG/_ENABLE_LOG/' Makefile.inc

#make clean
#make -j4
cd leveldb-1.14.0
sudo rm -rf /mnt/pmfs/*
cd $DATADIR
sudo $NVMDIR/likwid_instrcnt.sh "$HOMEDIR/leveldb-1.14.0/db_bench_mem_sqlite3_nojournal"



