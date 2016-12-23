Now  - utilities for tracking time
=

Bashed on a Hacker News comment (<https://news.ycombinator.com/item?id=7411120>), these utilities are meant to make it very easy to track time from the terminal.

Usage:
  now Working on Project A 
  now Working on Project B
  now break 
  now Working on Project A 
  now break 

Using now
-----------

Here's how to use `now`:

Whenever you start a new task, for example, working for client Miller,
just type:

    > now Working for Miller client

The `now` script will record this task along with a timestamp in the
file `.now` in your home directory. The effect is a build a
chronological list of the things you've worked on.

Advantages of now
---------------

Because `now` is very simple, it's easy to understand, easy to use, and easy to correct. If you make a mistake, just correct the `.now` file directly. Add entries. Delete entries. Change times. It's easy when all you're dealing with is a text file.

Installation
---

To install, download file `now`into a directory in your path.  For
autocompletion, downloadsource the `_now_bash_completion.sh` file in your `.profile` or
`.bashrc`.

Feedback
----

Send feedback to dpatru@gmail.com or github.com/dpatru/now


Thanks
------

Thanks to hn user judoyr for the idea. 

