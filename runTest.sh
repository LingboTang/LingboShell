# runTest.sh
# Author: Lingbo


rm -f testBuild.c
cat common.c > testBuild.c
cat $1 >> testBuild.s
gcc -Wall -std=c99 testBuild.c $2 | sed '1,5d' -g
