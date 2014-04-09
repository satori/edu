# Copyright (C) 2014 by Maxim Bublis <b@codemonkey.ru>
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OF OTHER DEALINGS IN THE SOFTWARE.

"""
Google Code Jam Practice Problems (2008) Problem C.
Usage:
    python c.py < input.txt > output.txt
"""
import collections
import sys

MAXINT = 2 ** 32


def solve_floors(drops, breaks):
    floors = 0

    q = collections.deque()
    q.append((drops, breaks))

    while q and floors < MAXINT:
        d, b = q.popleft()

        b = min([d, b])

        if b >= 32:
            floors = sys.maxint
        elif b == 1:
            floors += d
        elif d < 300:
            floors += solve_floors_r(d, b)
        else:
            floors += 1
            q.append((d - 1, b - 1))
            q.append((d - 1, b))

    return floors


def memoized(func):
    cache = {}
    def wrapped(*args):
        if not args in cache:
            cache[args] = func(*args)
        return cache[args]
    return wrapped


@memoized
def solve_floors_r(drops, breaks):
    if breaks == 0 or drops == 0:
        return 0

    return 1 + solve_floors_r(drops - 1, breaks - 1) + solve_floors_r(drops - 1, breaks)


def solve_drops(floors, breaks):
    drops = 1
    while True:
        if solve_floors(drops, breaks) >= floors:
            return drops
        drops += 1


def solve_breaks(floors, drops):
    breaks = 1
    while True:
        if solve_floors(drops, breaks) >= floors:
            return breaks
        breaks += 1


def solve_problem(floors, drops, breaks):
    solved_floors = solve_floors(drops, breaks)
    solved_drops = solve_drops(floors, breaks)
    solved_breaks = solve_breaks(floors, drops)

    return -1 if solved_floors >= MAXINT else solved_floors, solved_drops, solved_breaks


if __name__ == "__main__":
    num_of_cases = int(sys.stdin.readline())
    for i in xrange(1, num_of_cases + 1):
        floors, drops, breaks = map(int, sys.stdin.readline().split())
        print "Case #{0}: {1} {2} {3}".format(i, *solve_problem(floors, drops, breaks))
