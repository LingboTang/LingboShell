# Go through all tests in the folder,
# calling runTest.sh on each of them.
# Results will be compared to the expected results.
# Will be able to decide success or failure based on
# the comparison.

echo "Running tests on $1"
for f in tests/*.c
  do
  rm -f test.out
  ./runTest.sh $1 $f > actual.out
  suf = ${f%.c}
  echo -n "${suf$**\/} : "
  if diff ${f%.c}.out actual.out >/dev/null ; then
    echo "Success"
  else 
    echo "Failed (Difference)"
    echo "========================= Expected =========================== ========================== Actual ============================"
		diff -y --left-column ${f%.c}.out actual.out
		echo "============================================================================================================================="
	fi
done
rm -f test.out actual.out testBuild.
