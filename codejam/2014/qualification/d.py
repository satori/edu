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
Google Code Jam 2014 Qualification Problem D
Usage:
    python d.py < input.txt > output.txt
"""
import sys


def play_dwar(naomi_blocks, ken_blocks):
    max_score = 0

    while naomi_blocks:
        if min(naomi_blocks) > min(ken_blocks):
            max_score += 1
            naomi_blocks = naomi_blocks[1:]
            ken_blocks = ken_blocks[1:]
        else:
            naomi_blocks = naomi_blocks[1:]
            ken_blocks = ken_blocks[:-1]

    return max_score


def play_war(naomi_blocks, ken_blocks):
    max_score = 0
    while naomi_blocks:
        if max(naomi_blocks) > max(ken_blocks):
            max_score += 1
            naomi_blocks = naomi_blocks[:-1]
            ken_blocks = ken_blocks[1:]
        else:
            naomi_blocks = naomi_blocks[:-1]
            ken_blocks = ken_blocks[:-1]

    return max_score


def solve_problem(naomi_blocks, ken_blocks):
    return play_dwar(naomi_blocks, ken_blocks), play_war(naomi_blocks, ken_blocks)


if __name__ == "__main__":
    num_of_cases = int(sys.stdin.readline().strip())
    for i in xrange(1, num_of_cases + 1):

        num_of_blocks = int(sys.stdin.readline().strip())

        naomi_blocks = sorted(map(float, sys.stdin.readline().strip().split()))
        ken_blocks = sorted(map(float, sys.stdin.readline().strip().split()))


        print "Case #{0}: {1} {2}".format(i, *solve_problem(naomi_blocks, ken_blocks))
