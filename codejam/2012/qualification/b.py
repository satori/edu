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
Google Code Jam 2012 Problem B
Usage:
    python b.py < input.txt > output.txt
"""
import itertools
import sys


def calc_possible(n):
    combinations = itertools.combinations_with_replacement(range(n), 3)  # 3 scores
    return itertools.ifilter(lambda (x, y, z): x + y + z == n, combinations)


def calc_surprising(n):
    results = list(itertools.ifilter(lambda scores: max(scores) - min(scores) == 2, calc_possible(n)))
    return results[0] if results else None


def calc_normal(n):
    results = list(itertools.ifilter(lambda scores: max(scores) - min(scores) <= 1, calc_possible(n)))
    return results[0] if results else None


def solve_problem():
    number_of_cases = int(sys.stdin.readline())

    for i in xrange(1, number_of_cases + 1):

        case = sys.stdin.readline().strip()
        result = 0
        num_of_googlers, num_of_surprising, desired_score, scores = case.split(' ', 3)
        num_of_googlers = int(num_of_googlers)
        num_of_surprising = int(num_of_surprising)
        desired_score = int(desired_score)
        scores = map(int, scores.split())

        possible_scores = []

        for k in xrange(num_of_googlers):

            normal = calc_normal(scores[k])
            surprising = calc_surprising(scores[k])

            possible_scores.append(((normal if normal else (0, 0, 0), 0), (surprising if surprising else (0, 0, 0), 1)))

        possible = list(itertools.ifilter(lambda scores: sum(map(lambda x: x[1], scores)) == num_of_surprising, itertools.product(*possible_scores)))
        result = max(map(lambda scores: sum(map(lambda x: int(max(x[0]) >= desired_score), scores)) if scores else 0, possible))

        sys.stdout.write('Case #{0}: {1}\n'.format(i, result))


if __name__ == '__main__':
    solve_problem()
