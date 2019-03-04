now  - command-line program for tracking and estimating time
============================================================

`now` is a command-line program that helps track time, generate
reports, and estimate. Tasks are stored in a human-readable text file
so it's easy to correct histories.

License
-------

`now` is MIT licensed.

Motivation 
----------

`now` was born out of a need to record time for time sheets which 
required daily totals. I wanted something lightweight and editable and was inpired 
by a Hacker News [comment](<https://news.ycombinator.com/item?id=7411120>). 

I added estimates to become a better estimator. I often 
underestimate how long programming projects would last and this would 
lead to overscheduling and frustration. `now` helps by making it easy to 
track how long projects take compared to my initial estimates. It also 
can create realistic estimates based on my past performance. 

Features and benefits 
---------------------

now is a command-line tool that stores its data in a human-readable 
text file. Benefits include:

- Fast: `now` is fast to use. Simply type what you're working on when 
  you start. If you're working on a previous task or on a task from 
  your project file, you can even use auto-completion. 

- Fast: `now` also runs fast. 

- Understandable: `now` stores data in an understandable text file. If 
  you want to correct it, just use a text editor. 

- Flexible: `now` accepts time estimates in hours or hours:minutes 
  format. Also, the output can be reported in different formats and 
  different aggregation periods. 


Installation 
------------

I run `now` on a macbook pro. It should also work in linux.

To install, download file `now` from http://github.com/dpatru/now into 
a directory in your `PATH`. Set any desired environment variables in 
your `.profile` or `.bashrc` files. For bash completion, put the 
following line in your `.profile` file:

    complete -C now now 

`now` is written in perl. You may need to install some modules from 
CPAN to get it to run. Just use the following command:

    cpan install Getopt::Long Pod::Usage Time::Piece Data::Dumper File::HomeDir Time::Seconds Scalar::Util List::Util Carp::Assert Text::ParseWords List::MoreUtils File::Basename List::Flatten File::ReadBackwards


If that doesn't work, you may have to run it as sudo:

    sudo cpan install Getopt::Long Pod::Usage Time::Piece Data::Dumper File::HomeDir Time::Seconds Scalar::Util List::Util Carp::Assert Text::ParseWords List::MoreUtils File::Basename List::Flatten File::ReadBackwards


Tutorial
--------


Setup the environment.


    bash-4.3$ export NOW_FILE=/Users/danielpatru/.now
    bash-4.3$ NOW_FILE=/Users/danielpatru/.now
    bash-4.3$ rm /Users/danielpatru/.now 
    bash-4.3$ touch /Users/danielpatru/.now 
    bash-4.3$ ls -l /Users/danielpatru/.now 
    -rw-r--r--  1 danielpatru  staff  0 Jan  6 17:22 /Users/danielpatru/.now 


Tell bash to use `now` for ifs own completion.


    bash-4.3$ complete -C now now

Add some tasks. Sleep between them so there is a difference in the timestamps.

    bash-4.3$ now task one
    starting task one
    bash-4.3$ sleep 60
    bash-4.3$ now task two
    starting task two
    bash-4.3$ sleep 60

Add tasks with estimates. Note that `now` will try to give you an
estimate of how long the task will take based on your previous
predictions. The predictions get more accurate as there are more
samples. The first task with an estimate cannot be simulated because
there is no history.

Estimates can be specified in hours as simple decimal number or in `hour:minute` format.

    bash-4.3$ now :10 ten minute task
    starting :10 ten minute task
    Simulating task of 0.17, percentiles . . . 
    now: Can't simulate because there are no prior tasks with estimates.
    bash-4.3$ sleep 60
    bash-4.3$ now .5 half hour task
    starting .5 half hour task
    Simulating task of 0.50, percentiles . . . 
         5%     15%     25%     35%     45%     55%     65%     75%     85%     95%
       0.05    0.05    0.05    0.05    0.05    0.05    0.05    0.05    0.05    0.05
    (based on 1 sample estimates and 1000 simulations)
    bash-4.3$ sleep 60

Nested or hierarchical tasks can be entered using a colon to separate
levels. `now` will report totals for each level.

    bash-4.3$ now project 1: subtask 1
    starting project 1: subtask 1
    bash-4.3$ sleep 60
    bash-4.3$ now project 1: subtask 2
    starting project 1: subtask 2
    bash-4.3$ sleep 60
    bash-4.3$ now :10 project 2: subtask 1
    starting :10 project 2: subtask 1
    Simulating task of 0.17, percentiles . . . 
         5%     15%     25%     35%     45%     55%     65%     75%     85%     95%
       0.01    0.01    0.01    0.01    0.01    0.02    0.02    0.02    0.02    0.02
    (based on 2 sample estimates and 1000 simulations)
    bash-4.3$ sleep 60
    bash-4.3$ now :20 project 2: subtask 2
    starting :20 project 2: subtask 2
    Simulating task of 0.33, percentiles . . . 
         5%     15%     25%     35%     45%     55%     65%     75%     85%     95%
       0.01    0.01    0.01    0.03    0.03    0.03    0.03    0.03    0.03    0.03
    (based on 3 sample estimates and 1000 simulations)
    bash-4.3$ sleep 60

A task is considered to last until the next task. You can use "dummy
tasks" to end a task. By default, the tasks "break" and "done" are
considered dummy tasks and will not be reported.


    bash-4.3$ now break
    starting break

`now` stores tasks in the nowfile (specified in NOW_FILE) in
human-readable format.


    bash-4.3$ tail /Users/danielpatru/.now
    2017-01-06 17:22:14 task one
    2017-01-06 17:23:14 task two
    2017-01-06 17:24:14 :10 ten minute task
    2017-01-06 17:25:14 .5 half hour task
    2017-01-06 17:26:14 project 1: subtask 1
    2017-01-06 17:27:14 project 1: subtask 2
    2017-01-06 17:28:14 :10 project 2: subtask 1
    2017-01-06 17:29:15 :20 project 2: subtask 2
    2017-01-06 17:30:15 break

Reports can be generated per day (-d), week (-w), and year (-y). Note
how totals are aggregated for each level for hierarchical tasks. This is
very useful for filling out timesheets.

Times are displayed as `elapsed_time/ estimated_time`. 

    bash-4.3$ now -d 1
    
    2017-01-06  0:08/ 1:09 (total)
         0:01/ 0:30 half hour task
         0:02/      (total) project 1
         0:01/      project 1: subtask 1
         0:01/      project 1: subtask 2
         0:02/ 0:30 (total) project 2
         0:01/ 0:10 project 2: subtask 1
         0:01/ 0:20 project 2: subtask 2
         0:01/      task one
         0:01/      task two
         0:01/ 0:10 ten minute task
    bash-4.3$ now -w 1
    
    2017 week 1 beginning Mon 2017-01-02   0:08/  1:09 (total)
          0:01/  0:30 half hour task
          0:02/       (total) project 1
          0:01/       project 1: subtask 1
          0:01/       project 1: subtask 2
          0:02/  0:30 (total) project 2
          0:01/  0:10 project 2: subtask 1
          0:01/  0:20 project 2: subtask 2
          0:01/       task one
          0:01/       task two
          0:01/  0:10 ten minute task
    bash-4.3$ now -y 1
    
    2017    0:08/   1:09 (total)
           0:01/   0:30 half hour task
           0:02/        (total) project 1
           0:01/        project 1: subtask 1
           0:01/        project 1: subtask 2
           0:02/   0:30 (total) project 2
           0:01/   0:10 project 2: subtask 1
           0:01/   0:20 project 2: subtask 2
           0:01/        task one
           0:01/        task two
           0:01/   0:10 ten minute task

Time format can be changed to `hours` using the `--time-format`
command-line option.

    bash-4.3$ now -d 1 --time-format h

    2017-01-06  0.13h/ 1.17h (total)  
         0.02h/ 0.50h half hour task  
         0.03h/       (total) project 1  
         0.02h/       project 1: subtask 1  
         0.02h/       project 1: subtask 2  
         0.03h/ 0.50h (total) project 2  
         0.02h/ 0.17h project 2: subtask 1  
         0.02h/ 0.33h project 2: subtask 2  
         0.02h/       task one  
         0.02h/       task two  
         0.02h/ 0.17h ten minute task  
 
The time format can also be set with the environment variable
`NOW_TIME_FORMAT`. Accceptable values are `h` (hours), `hm`
(hours:minutes), `hms` (hours:minutes:seconds), and `m`
(minutes). 

    bash-4.3$ export NOW_TIME_FORMAT=h
    NOW_TIME_FORMAT=h 
    bash-4.3$ now -d 1
    
    2017-01-06  0.13h/ 1.17h (total) 
         0.02h/ 0.50h half hour task 
         0.03h/       (total) project 1 
         0.02h/       project 1: subtask 1 
         0.02h/       project 1: subtask 2 
         0.03h/ 0.50h (total) project 2 
         0.02h/ 0.17h project 2: subtask 1 
         0.02h/ 0.33h project 2: subtask 2 
         0.02h/       task one 
         0.02h/       task two 
         0.02h/ 0.17h ten minute task

Multiple formats can be shown by joining the formats with commas. 

	 bash-4.3$ now -d 1 --time-format hms,m 
		 
		 2017-01-06  0:08:01/ 1:09:59    8m/  70m (total)
     0:01:00/ 0:30:00    1m/  30m half hour task
     0:02:00/            2m/      (total) project 1
     0:01:00/            1m/      project 1: subtask 1
     0:01:00/            1m/      project 1: subtask 2
     0:02:00/ 0:30:00    2m/  30m (total) project 2
     0:01:00/ 0:10:00    1m/  10m project 2: subtask 1
     0:01:00/ 0:20:00    1m/  20m project 2: subtask 2
     0:01:00/            1m/      task one
     0:01:00/            1m/      task two
     0:01:00/ 0:10:00    1m/  10m ten minute task
    bash-4.3$ export NOW_TIME_FORMAT=hm
    NOW_TIME_FORMAT=hm


By default, breaks are not shown. They can be shown with the `--nobreak` option.

    bash-4.3$ now -d 1 --nobreak 
    
    2017-01-06  0:08/ 1:09 (total)
         0:00/      break
         0:01/ 0:30 half hour task
         0:02/      (total) project 1
         0:01/      project 1: subtask 1
         0:01/      project 1: subtask 2
         0:02/ 0:30 (total) project 2
         0:01/ 0:10 project 2: subtask 1
         0:01/ 0:20 project 2: subtask 2
         0:01/      task one
         0:01/      task two
         0:01/ 0:10 ten minute task

Reports can also be generated without showing estimates using the 
--noestimates flag. 


    bash-4.3$ now --noestimates -d 1 
    
    2017-01-06  0:08 (total)
         0:01 half hour task
         0:02 (total) project 1
         0:01 project 1: subtask 1
         0:01 project 1: subtask 2
         0:02 (total) project 2
         0:01 project 2: subtask 1
         0:01 project 2: subtask 2
         0:01 task one
         0:01 task two
         0:01 ten minute task
    
`now` can run simulations to find an expected distribution for how
long tasks will take based on your history of estimations and actual
time spent. This is called *evidence-based-scheduling. Joel Spolsky
has written about EBS
[here](https://www.joelonsoftware.com/2007/10/26/evidence-based-scheduling/).
To find out how long you can expect to spend on two tasks estimated at
five and ten minutes, simply call `now` with these times. If all of
the arguments look like numbers or times, then `now` will simulate.

    bash-4.3$ now :05 :10
    Simulating tasks of 0.08, 0.17 = 0.25 total, percentiles . . . 
         5%     15%     25%     35%     45%     55%     65%     75%     85%     95%
       0.01    0.01    0.01    0.01    0.02    0.02    0.02    0.03    0.03    0.03
    (based on 4 sample estimates and 1000 simulations)

You can also organize your projects in org-mode style with estimates
appended and `now` can simulate projects using the `-e` option (-e
stands for estimate). Project file is specified in the `NOW_PROJECTS`
environment variable.


    bash-4.3$ ls -l /Users/danielpatru/.projects.org
    -rw-r--r--  1 danielpatru  staff  105 Jan  6 14:07 /Users/danielpatru/.projects.org
    bash-4.3$ export NOW_PROJECTS=/Users/danielpatru/.projects.org
    NOW_PROJECTS=/Users/danielpatru/.projects.org
    bash-4.3$ cat - > $NOW_PROJECTS <<EOF
    * project one
    ** first task :10
    ** second task :20
    
    * project two
    ** first task 1:10
    ** second task 1:20
    EOF
    bash-4.3$ cat /Users/danielpatru/.projects.org
    * project one
    ** first task :10
    ** second task :20
    
    * project two
    ** first task 1:10
    ** second task 1:20
    bash-4.3$ now -e
    project one: Simulating tasks of 0.17, 0.33 = 0.5 total, percentiles . . . 
         5%     15%     25%     35%     45%     55%     65%     75%     85%     95%
       0.02    0.02    0.03    0.03    0.03    0.04    0.04    0.05    0.05    0.05
    (based on 4 sample estimates and 1000 simulations)
    
    project two: Simulating tasks of 1.17, 1.33 = 2.5 total, percentiles . . . 
         5%     15%     25%     35%     45%     55%     65%     75%     85%     95%
       0.08    0.11    0.16    0.16    0.17    0.18    0.19    0.25    0.25    0.25
    (based on 4 sample estimates and 1000 simulations)

You can also simulate just a particular project. Auto-completion helps
here (when `now` sees the -e option, it completes from the project
file. 

    bash-4.3$ now -e project one
    project one: Simulating tasks of 0.33, 0.17 = 0.5 total, percentiles . . . 
         5%     15%     25%     35%     45%     55%     65%     75%     85%     95%
       0.02    0.02    0.03    0.03    0.03    0.04    0.04    0.04    0.05    0.05
       (based on 4 sample estimates and 1000 simulations)

Use the `--help` option to get more extensive help.

    bash-4.3$ now --help
    now EXAMPLES
        now prog: docs # Add task "prog: docs" to .now file.
    
        now 12 prog: plan # Add task "prog: plan" with estimate 12 minutes.
    
        now # Print report.
    
        now -t 4 # Print report of the last 4 tasks
    
        now -d 4 # Print report of the last 4 days.
    
        now -w 4 # Print report of the last 4 weeks.
    
        now 5 # Estimate duration of task estimated to be 5 minutes.
    
        now 5 10 3 # Estimate the duration of tasks estimated to be # 5, 10, and
        3 hours.
    
        now -r a # Resume task a.
    
        now -r 5 a # Resume task a, changing estimated time to 5hrs.
    
        now -e [project] # Simulate the projects in the project file.
    
        now -p ... # Autocomplete from project file.
    
    SYNOPSIS
        sample [options] [file ...]
    
         Options:
           -h|?              brief help message
           --help | --man    full documentation
           --version         print version and exit
           --verbose | -v    print processed lines before reports
           --time-format h   print report in hours (default)
           --time-format m   print report in minutes instead of hours
           --time-format hm  print report in hours and minutes
           --nobreak         do not skip breaks
           --breakword stop  use "stop" as the breakword instead of "break".
           --estimates       show estimates when reporting
           --noestimates     turn off estimates when reporting
           --sunday          start the week on sunday for weekly reports
           --monday          start the week on monday (default)
           --samples 1000    number of sample estimates to use for simulation
           --tries 100       number of times to simulate
           -f mynowfile      use now file mynowfile (default is ~/.now)
           -t 5              show 5 tosks
           -d 5              show 5 days
           -w 5              show 5 weeks
           -e                estimate projects from project file
           --projects myfile use myfile as projects file
           -r task           resume from an interuption
           --resume task     resume from an interuption
           --DEBUG           show settings
    
    OPTIONS
        -h
          Print a brief help message and exits.
    
        --help
          Prints the manual page and exits.
    
        --breakword stop,quit
          Use "stop" or "quit" as breakwords instead of the default or the
          environment-defined breakword. Multiple words can be defined by
          separating with commas or using multiple --breakword options. The
          default breakword is "break". The default breakword can be set by the
          environment variable "NOW_BREAK_WORD".
    
          Breakwords are used to end a task without starting a new one. Breaks
          are normally ignored when reporting.
    
        --sunday, --nosunday
          For weekly reporting, the week starts on Monday. According to
          http://perldoc.perl.org/Time/Piece.html#Week-Number:
    
            The week number may be an unknown concept to some readers. The ISO
            8601 standard defines that weeks begin on a Monday and week 1 of the
            year is the week that includes both January 4th and the first
            Thursday of the year. In other words, if the first Monday of January
            is the 2nd, 3rd, or 4th, the preceding days of the January are part
            of the last week of the preceding year. Week numbers range from 1 to
            53.
    
          Use the --sunday option to start the week on Sunday for weekly
          reports. The number of the week will still follow ISO 8601, but Sunday
          will be treated as belonging to the following week (that starts the
          next Monday.) This can also be set with the environment variable
          NOW_SUNDAY=1.
    
        --samples 1000, --tries 1000
          When simulating tasks, there are two parameters that can be adjusted.
          samples is the number of velocities that are pulled from the nowfile.
          (A velocity is the ratio of the estimated time divided by the actual.
          A velocity of 1 means that time went as expected. A velocity of 2
          means that task went twice as fast as expected.) The velocities are
          taken in reverse order (from the bottom of the nowfile).
    
          Once the samples are taken, the task is simulated by dividing the
          estimates by a randomly chosen velocity. The results are then sorted
          and the 5th, 15th, 25th, ..., 95th percentiles are taken. The number
          of simulations is the number of tries. To get a more probabalistically
          accurate estimate, increase the number of tries. A smaller samples
          ignores older velocities.
    
          See
          https://www.joelonsoftware.com/2007/10/26/evidence-based-scheduling/
          for more information.
    
        --pretty
          Pretty-print reports. Don't print the datetime for every line. This
          gives a cleaner look.
    
        --ugly
          Ugly-print reports. Print the datetime for every line. This may be
          more useful for filling out timesheets as it reduces eye-movement.
    
        --projects projectfile.org, -p projectfile.org
          Sets the projects file. Should be in org-mode format with (optional)
          estimates at the end of headers. This can also be set by environment
          variable. By default, projects files are located at
          ~/Dropbox/.projects.org or ~/.projects.
    
        -e
          Estimate how long each project in the project file will take. If a
          project is given, only projects that match will be estimated.
    
        -p
          Autocomplete from project file and not from now file.
    
        --resume task, -r task
          Resume a task that has been interupted. This command will try to
          rewrite the nowfile to correct an estimate with respect to an
          interuption. The goal is to make it easy to recover from an
          interuption so that it is recorded. An example should make this clear.
    
          Note that the task name must match exactly. But this is easy to do
          with autocomplete.
    
            $ now 2 a
    
            $ # work for an hour
    
            $ now interuption
    
            $ now -t 2
    
            xxxx-xx-xx 00:00:00 1hr/3hr a
    
            xxxx-xx-xx 01:00:00 xhr/ interuption
    
            $ now -r a; now -t 3
    
            xxxx-xx-xx 00:00:00 1hr/1hr a
    
            xxxx-xx-xx 01:00:00 xhr/ interuption
    
            xxxx-xx-xx 01:10:00 0hr/2hr a
    
            $ # Note that the first a's estimate was reset to 1hr, the amount
            used, while the rest of the estimate was used for the second a. The
            interuption did not ruin the estimate.
    
        --DEBUG
          Print the settings (nowfile, verbose, sunday, ...) to stderr before
          running.
    
    DESCRIPTION
        now is a simple, text-based, shell-based time tracker suitable for
        tracking time at the terminal and completing time sheets. Tasks are
        stored in a text file ~/Dropbox/.now or ~/.now. Tasks are stored in the
        .now file, one task per line, prepended by a timestamp and an optional
        estimate (in hours). You can easily edit this file by hand. This utility
        just makes common tasks easier.
    
        now has three modes of use: (1) real-time tracking mode, (2) report
        mode, and (3) estimation mode.
    
      REAL-TIME TRACKING
        To use the real-time tracking mode, call now with the task. The task
        will be appended the .now file with the current time. Call now with a
        new task, or a "break" task when the current task is done.
    
          now programming: finish docs # start tracking "programming: docs" now
    
        You can also add an estimate in hours or h:m.
    
          now :10 my task # start tracking "my task" now, estimate 10 minutes
    
          now 2.5 my long task # start tracking "my long task" now, estimate 2.5
          hours
    
      REPORTING
        Use the -d, -w, or -t options for report mode. This will print a report
        of the last n days, weeks, or tasks respectively. Colons (:) are used to
        mark task categories. Reports break down time spent hierachially in each
        category and task. The -v or --verbose option will print the tasks
        processed before the report.
    
      ESTIMATING
        Calling now with a list of estimates will produce a time range based on
        past estimates in the now file. See evidence-based scheduling and
        http://www.joelonsoftware.com/items/2007/10/26.html.
    
    HOW TO USE THIS FOR ESTIMATING
        Past estimates are taken from past tasks for which estimates are given.
        IT IS ASSUMED THAT TASKS ARE COMPLETED. So once you give an estimate,
        strive to complete the task. If you don't complete it, don't give the
        estimate, because the estimate will not mean anything. This may mean
        that you will have to track very small tasks (with small estimates) so
        that you can actually complete them.
    
        For example, if you estimate that task A should take 1 hour, and you
        work on it for an hour and thirty minutes and then are interupted and
        work on something else without completing task A, then now will think
        that you actually completed the task at 150% of your estimate, when you
        actually did potentially far worse. Your smulation results will be off.
    
        In this case, you should have split up your one hour task into samller
        tasks of perhaps fifteen minutes. Then you would have had up to an hour
        and a half to complete your fifteen-minute task before being interupted.
    
        To get the most from now, use break up your work into lots of little
        tasks with relatively small estimates. When you start a task, strive to
        finish it.
    
    HOW TO INSTALL
        Put the now perl file somewhere in your path. Add the following line to
        your ~/.profile:
    
          # call the command now to autocomplete now (now is it's own
          autocompletor.
    
          complete -C now now
    
    CUSTOMIZATION
        You can set some options using environment variables. The following is a
        sample ~/.profile.
    
          # set the .now file to ~/mydir/.now
    
          export NOW_qFILE=~/mydir/.now
    
          # Treat stop, break, quit, and done as breakwords.
    
          export NOW_BREAK_WORD=stop,break,quit,done
    
          # Silent operation
    
          export NOW_SILENT=1
    
          # include estimates in reports.
    
          export NOW_ESTIMATES=1
    
          # set the time format for reports
    
          export NOW_TIME_FORMAT=hm
    
          # Start weeks on Sunday.
    
          export NOW_SUNDAY=1
    
          # Start weeks on Monday.
    
          export NOW_SUNDAY=0
    
          # Set the default samples and tries.
    
          export NOW_SAMPLES=100
    
          export NOW_TRIES=80
    
          # Set number of lines to read from now file when bash completing
    
          export NOW_COMPLETION_HISTORY=1000
    
          # Set the max number of choices to present when bash completing
    
          export NOW_COMPLETION_CHOICES=20
    
          # Set the DEBUG flag (show settings)
    
          export NOW_DEBUG=1
    
          # Set the projects file
    
          export NOW_PROJECTS=~/myprojects.org

    
    
Feedback
--------

Send feedback to dpatru@gmail.com or github.com/dpatru/now


Thanks
------

Thanks to hn user [judofyr](https://news.ycombinator.com/user?id=judofyr) for the idea. 


