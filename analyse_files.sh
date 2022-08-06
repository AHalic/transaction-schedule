echo "Comparing files $1 and $2"
diff --side-by-side --ignore-all-space $1 $2
comp_value=$?

if [ $comp_value -eq 1 ]
then
    echo "TEST FAILED"
else
    echo "TEST PASSED"
fi