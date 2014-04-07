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
Google Code Jam 2012 Problem C
Usage:
    python c.py < input.txt > output.txt
"""
import itertools
import sys


def solve_problem(numbers):
    sums = {}
    for l in xrange(len(numbers) + 1):
        for combination in itertools.combinations(numbers, l):
            combination = set(combination)
            sum_of_combination = sum(combination)
            if not sum_of_combination in sums:
                sums[sum_of_combination] = combination
            elif not sums[sum_of_combination] & combination:
                    result = []
                    result.append(' '.join(map(str, combination)))
                    result.append(' '.join(map(str, sums[sum_of_combination])))
                    return '\n'.join(result)
    return 'Impossible\n'

def main():
    number_of_cases = int(sys.stdin.readline())

    for i in xrange(1, number_of_cases + 1):
        numbers = map(int, sys.stdin.readline().split()[1:])
        sys.stdout.write('Case #{0}:\n{1}\n'.format(i, solve_problem(numbers)))

if __name__ == '__main__':
    main()
