#!/bin/sh

LIKDIWDPATH=$NVMALLOC_HOME/scripts/likwid_instrcnt.sh
PARALLEL="-j8"

case "$1" in
        compile)

	echo "cleaning and compiling "
	rm -rf db_bench_mem_sqlite3*

	cp makefiles/Makefile_NOJOURNAL Makefile
	make clean > compile.out && make $PARALLEL > compile.out
	cp db_bench_mem_sqlite3 db_bench_mem_sqlite3_nojournal

	cp makefiles/Makefile_ATOMIC Makefile
	make clean > compile.out && make $PARALLEL > compile.out
	cp db_bench_mem_sqlite3 db_bench_mem_sqlite3_atomic

	cp makefiles/Makefile_ATOMIC_MEMJOURNAL Makefile
	make clean > compile.out && make $PARALLEL > compile.out
	cp db_bench_mem_sqlite3 db_bench_mem_sqlite3_atomic_memjournal

	cp makefiles/Makefile_WAL Makefile
	make clean > compile.out && make $PARALLEL > compile.out
	cp db_bench_mem_sqlite3 db_bench_mem_sqlite3_wal


	cp makefiles/Makefile_WAL_MEMJOURNAL Makefile
	make clean > compile.out && make $PARALLEL > compile.out
	cp db_bench_mem_sqlite3 db_bench_mem_sqlite3_wal_memjournal

	cp makefiles/Makefile_WALDISABLE Makefile
	make clean > compile.out && make $PARALLEL > compile.out
	cp db_bench_mem_sqlite3 db_bench_mem_sqlite3_waldisabled


	cp makefiles/Makefile_WALDISABLE_MEMJOURNAL Makefile
	make clean > compile.out && make $PARALLEL > compile.out
	cp db_bench_mem_sqlite3 db_bench_mem_sqlite3_waldisabled_memjournal
        ;;
	
	*)
	 echo "not compiling, only running"
	 
esac


case "$2" in
	-logtype)
	echo "running $3"
	$LIKDIWDPATH "numactl --membind=0 ./$3"
	echo "................."
	;;

	-likwid)
	echo "Running all log mechanisms "


	echo "running sqlite_nojournal"
	$LIKDIWDPATH "numactl --membind=0 ./db_bench_mem_sqlite3_nojournal"
	echo "................."

	echo "running sqlite3_atomic"
	$LIKDIWDPATH "numactl --membind=0 ./db_bench_mem_sqlite3_atomic"
	echo "................."


	#echo "running sqlite3_atomic_memjournal"
	#$LIKDIWDPATH "numactl --membind=0 ./db_bench_mem_sqlite3_atomic_memjournal"
	#echo "................."


	echo "running sqlite3_wal"
	$LIKDIWDPATH "numactl --membind=0 ./db_bench_mem_sqlite3_wal"
	echo "................."



	#echo "running sqlite3_wal_memjournal"
	#$LIKDIWDPATH "numactl --membind=0 ./db_bench_mem_sqlite3_wal_memjournal"
	#echo "................."


	echo "running sqlite3_waldisabled"
	$LIKDIWDPATH "numactl --membind=0 ./db_bench_mem_sqlite3_waldisabled"
	echo "................."


	#echo "running sqlite3_waldisabled_memjournal"
	#$LIKDIWDPATH "numactl --membind=0 ./db_bench_mem_sqlite3_waldisabled_memjournal"
	#echo "................."
	;;

	*)
	echo "Running all log mechanisms "

	echo "running sqlite_nojournal"
	numactl --membind=0 ./db_bench_mem_sqlite3_nojournal
	echo "................."

	echo "running sqlite3_atomic"
	numactl --membind=0 ./db_bench_mem_sqlite3_atomic
	echo "................."

	echo "running sqlite3_wal"
	numactl --membind=0 ./db_bench_mem_sqlite3_wal
	echo "................."

	echo "running sqlite3_waldisabled"
	numactl --membind=0 ./db_bench_mem_sqlite3_waldisabled
	echo "................."
	;;

esac
