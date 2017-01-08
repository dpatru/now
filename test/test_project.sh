#! /usr/bin/bash

cat - > test_project.org <<EOF
* A
** a :10
** b :20
** c :30
EOF

export NOW_PROJECT=test_project.org

now -p | grep -q 'a' && echo FAIL
now -p | grep -q 'b' && echo FAIL
now -p | grep -q 'c' && echo FAIL
now -p | grep -q 'A' && echo OK

