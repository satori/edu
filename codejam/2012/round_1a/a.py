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
import sys

ENTER = 1


def solve_problem():
    number_of_cases = int(sys.stdin.readline())

    for i in xrange(1, number_of_cases + 1):
        typed, total = sys.stdin.readline().split()
        typed = int(typed)
        total = int(total)

        corrects_ratio = map(float, sys.stdin.readline().split())
        errors_ratio = map(lambda x: 1.0 - x, corrects_ratio)
        all_expected = []

        for k in xrange(typed + 1):
            correct_ratio = reduce(lambda x, y: x * y, corrects_ratio[:typed - k], 1.0)
            correct_keystrokes = total - typed + ENTER + k * 2
            error_ratio = 1.0 - correct_ratio
            error_keystrokes = correct_keystrokes + total + ENTER
            if k == typed:
                error_keystrokes = correct_keystrokes
            expected = error_ratio * error_keystrokes + correct_ratio * correct_keystrokes
            all_expected.append(expected)

        expected_enter = ENTER + total + ENTER
        all_expected.append(expected_enter)

        sys.stdout.write('Case #{0}: {1:f}\n'.format(i, min(all_expected)))


if __name__ == '__main__':
    solve_problem()
