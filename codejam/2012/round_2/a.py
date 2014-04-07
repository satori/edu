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
Google Code Jam 2012 Problem A
Usage:
    python a.py < input.txt > output.txt
"""
import multiprocessing
import sys


def solve((vines, distance, current_position, swing_distance)):
    if (current_position + swing_distance) >= distance:
        return True

    matched_vines = filter(lambda v: v[0] > current_position and v[0] <= (current_position + swing_distance), vines)
    best_matched_vines = []
    for vine in matched_vines:
        if vine[0] + min([vine[0] - current_position, vine[1]]) >= distance or \
            filter(lambda v: v[0] > vine[0] and v[0] <= (vine[0] + min([vine[0] - current_position, vine[1]])) and not v in matched_vines, vines):
            best_matched_vines.append(vine)

    for vine in best_matched_vines:
        possible_distance = min([vine[0] - current_position, vine[1]])
        possible_position = vine[0]
        if solve((filter(lambda v: v[0] >= vine[0], vines), distance, possible_position, possible_distance)):
            return True

    return False


def main():
    number_of_cases = int(sys.stdin.readline())

    pool = multiprocessing.Pool(processes=number_of_cases)
    args = []

    for i in xrange(1, number_of_cases + 1):
        num_vines = int(sys.stdin.readline())

        vines = []
        for k in xrange(num_vines):
            vines.append(map(int, sys.stdin.readline().strip().split()))

        distance = int(sys.stdin.readline())

        args.append((vines, distance, vines[0][0], vines[0][0]))

    results = pool.map(solve, args)

    for i, result in enumerate(results):
        sys.stdout.write('Case #{0}: {1}\n'.format(i + 1, 'YES' if result else 'NO'))


if __name__ == '__main__':
    main()
