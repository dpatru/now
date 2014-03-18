Now  - utilities for tracking time
=

Bashed on a Hacker News comment (<https://news.ycombinator.com/item?id=7411120>), these utilities are meant to make it very easy to track time from the terminal.

Usage:
  now "Working on Project A"
  now pause
  now continue
  now done

Using now
-----------

Here's how to use `now`:

Whenever you start a new task, for example, working for client Miller, just type:

    > now Working for Miller client

The `now` script will record this task along with a timestamp in the file `.now` in your home directory. The effect is a build a chronological list of the things you've worked on.

The script `nowtss` takes a timestamped list of tasks and adds elapsed time. As a convenience, `now` shows the output of nowtss on the tail of the `.now` file each time it is called.

Advantages of now
---------------

Because `now` is very simple, it's easy to understand, easy to use, and easy to correct. If you make a mistake, just correct the `.now` file directly. Add entries. Delete entries. Change times. It's easy when all you're dealing with is a text file.

Installation
---

To install, copy the files `now` and `nowtss` to a directory in your path.


Thanks
------

Thanks to hn user judoyr for the idea. 

