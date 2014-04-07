# Copyright (C) 2013 by Maxim Bublis <b@codemonkey.ru>
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
Google Code Jam 2013 Problem B
Usage:
    python b.py < input.txt > output.txt
"""
import sys

def solve_problem(lawn, size_x, size_y):
    for i in xrange(size_x):
        for k in xrange(size_y):
            elem = lawn[i][k]
            if max(lawn[i]) > elem and max([lawn[j][k] for j in xrange(size_x)]) > elem:
                return 'NO'

    return 'YES'

def read_lawn(stdin, size_x, size_y):
    lawn = []
    for i in xrange(size_x):
        line = map(int, sys.stdin.readline().strip().split(' '))
        lawn.append(line)
    return lawn


if __name__ == '__main__':
    num_of_cases = int(sys.stdin.readline())
    for i in xrange(1, num_of_cases + 1):
        size_x, size_y = map(int, sys.stdin.readline().strip().split(' '))
        lawn = read_lawn(sys.stdin, size_x, size_y)
        print 'Case #{0}: {1}'.format(i, solve_problem(lawn, size_x, size_y))
