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
Google Code Jam Round 1A Problem A.
Usage:
    python a.py < input.txt > output.txt
"""
import operator
import sys


def solve_problem(v1, v2):
    v1 = sorted(v1)
    v2 = sorted(v2, reverse=True)
    return reduce(operator.add, map(lambda (x, y): x * y, zip(v1, v2)))


if __name__ == "__main__":
    num_of_cases = int(sys.stdin.readline())
    for i in xrange(1, num_of_cases + 1):
        num_integers = int(sys.stdin.readline())
        v1 = map(int, sys.stdin.readline().strip().split())
        v2 = map(int, sys.stdin.readline().strip().split())
        print "Case #{0}: {1}".format(i, solve_problem(v1, v2))
