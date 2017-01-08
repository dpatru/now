#!/bin/bash
set -o


# setup environment

export NOW_FILE=~/.now

# start with a new now file for demo purposes
rm $NOW_FILE
touch $NOW_FILE
ls -l $NOW_FILE

# setup autocomplete (bash only)
complete -C now now

# add some tasks
now task one
sleep 60
now task two
sleep 60

# add tasks with estimates
now :10 ten minute task
sleep 60
now .5 half hour task
sleep 60

# add nested tasks
now project 1: subtask 1
sleep 60
now project 1: subtask 2
sleep 60

# add nested tasks with estimates
now :10 project 2: subtask 1
sleep 60
now :20 project 2: subtask 2
sleep 60
now break

# look at nowfile
tail $NOW_FILE

# print report for the last (one) day, week, and year
now -d 1
now -w 1
now -y 1

# Display the time in hours:minutes . . .
now -d 1 --time-format hm

# Set the time format with environment variable.
export NOW_TIME_FORMAT=hm

# Multiple formats can be shown by joining the formats with commas. 
now -d 1 --time-format hms,m 

# Include breaks in reports
now -d 1 --nobreak

# Reports can also be generated without showing estimates using the --noestimates flag. 
bash-4.3$ now --noestimates -d 1

# simulate how long it will take to finish two projects estimated at 5 and 10 minutes.
now :05 :10

# add a project file

ls -l ~/.projects.org # should be nothing here

export NOW_PROJECTS=~/.projects.org

cat - > $NOW_PROJECTS <<EOF
* project one
** first task :10
** second task :20

* project two
** first task 1:10
** second task 1:20
EOF

cat $NOW_PROJECTS # check 

# how long should it take to finish the projects? (estimate)
now -e

# how long will it take to finish just project one?
now -e project one

# get more information
now --help | cat





