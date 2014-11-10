#!/bin/sh

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



