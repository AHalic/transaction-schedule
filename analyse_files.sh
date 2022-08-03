diff --brief $1 $2 >/dev/null
comp_value=$?

if [ $comp_value -eq 1 ]
then
    echo "TEST FAILED"
else
    echo "TEST PASSED"
fi