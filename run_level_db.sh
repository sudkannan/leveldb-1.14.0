#!/bin/sh


rm -rf db_bench_mem_sqlite3*

if true; then
cp makefiles/Makefile_ATOMIC Makefile
make clean > compile.out && make -j16 > compile.out
cp db_bench_mem_sqlite3 db_bench_mem_sqlite3_atomic

cp makefiles/Makefile_ATOMIC_MEMJOURNAL Makefile
make clean > compile.out && make -j16 > compile.out
cp db_bench_mem_sqlite3 db_bench_mem_sqlite3_atomic_memjournal

cp makefiles/Makefile_WAL Makefile
make clean > compile.out && make -j16 > compile.out
cp db_bench_mem_sqlite3 db_bench_mem_sqlite3_wal


cp makefiles/Makefile_WAL_MEMJOURNAL Makefile
make clean > compile.out && make -j16 > compile.out
cp db_bench_mem_sqlite3 db_bench_mem_sqlite3_wal_memjournal

cp makefiles/Makefile_WALDISABLE Makefile
make clean > compile.out && make -j16 > compile.out
cp db_bench_mem_sqlite3 db_bench_mem_sqlite3_waldisabled


cp makefiles/Makefile_WALDISABLE_MEMJOURNAL Makefile
make clean > compile.out && make -j16 > compile.out
cp db_bench_mem_sqlite3 db_bench_mem_sqlite3_waldisabled_memjournal

fi

echo "runnng sqlite3_atomic"
numactl --membind=1 ./db_bench_mem_sqlite3_atomic
echo "................."


echo "runnng sqlite3_atomic_memjournal"
numactl --membind=1 ./db_bench_mem_sqlite3_atomic_memjournal
echo "................."


echo "runnng sqlite3_wal"
numactl --membind=1 ./db_bench_mem_sqlite3_wal
echo "................."



echo "runnng sqlite3_wal_memjournal"
numactl --membind=1 ./db_bench_mem_sqlite3_wal_memjournal
echo "................."


echo "runnng sqlite3_waldisabled"
numactl --membind=1 ./db_bench_mem_sqlite3_waldisabled
echo "................."


echo "runnng sqlite3_waldisabled_memjournal"
numactl --membind=1 ./db_bench_mem_sqlite3_waldisabled_memjournal
echo "................."


