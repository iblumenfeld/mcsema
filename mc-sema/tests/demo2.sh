#!/bin/bash

source env.sh

rm -f demo_test2.cfg demo_driver2.o demo_test2.o demo_test2_mine.o demo_driver2.exe

nasm -f elf32 -o demo_test2.o demo_test2.asm 

if [ -e "${IDA_PATH}/idaq" ]
then
    echo "Using IDA to recover CFG"
    ${BIN_DESCEND_PATH}/bin_descend_wrapper.py -march=x86 -d -entry-symbol=start -i=demo_test2.o>> /dev/null
else
    echo "Using bin_descend to recover CFG"
    ${BIN_DESCEND_PATH}/bin_descend -march=x86 -d -entry-symbol=start -i=demo_test2.o
fi

${CFG_TO_BC_PATH}/cfg_to_bc -mtriple=i686-pc-linux-gnu -i demo_test2.cfg -driver=demo2_entry,start,raw,return,C -o demo_test2.bc

${LLVM_PATH}/opt -march=x86 -O3 -o demo_test2_opt.bc demo_test2.bc
${LLVM_PATH}/llc -filetype=obj -o demo_test2_mine.o demo_test2_opt.bc
${CC} -m32 -o demo_driver2.exe demo_driver2.c demo_test2_mine.o
./demo_driver2.exe
