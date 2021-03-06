
#!/bin/bash

source env.sh

rm -f demo_test8.cfg demo_driver8.o demo_test8.o demo_test8_mine.o demo_driver8.exe

${CC} -ggdb -m64 -c -o demo_test8.o demo_test8.c

if [ -e "${IDA_PATH}/idaq" ]
then
    echo "Using IDA to recover CFG"
    ${BIN_DESCEND_PATH}/bin_descend_wrapper.py -march=x86-64 -entry-symbol=doOp -i=demo_test8.o >> /dev/null
else
    echo "Using bin_descend to recover CFG"
    ${BIN_DESCEND_PATH}/bin_descend -march=x86-64 -d -entry-symbol=doOp -i=demo_test8.o
fi

${CFG_TO_BC_PATH}/cfg_to_bc -mtriple=x86_64-pc-linux-gnu -i demo_test8.cfg -driver=demo8_entry,doOp,1,return,C -o demo_test8.bc

${LLVM_PATH}/opt -O3 -o demo_test8_opt.bc demo_test8.bc
${LLVM_PATH}/llc -march=x86-64 -filetype=obj -o demo_test8_mine.o demo_test8_opt.bc
${CC} -ggdb -m64 -o demo_driver8.exe demo_driver8.c demo_test8_mine.o
./demo_driver8.exe
