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
Google Code Jam 2013 Problem A
Usage:
    python a.py < input.txt > output.txt
"""
import sys

vowels = set(['a', 'e', 'i', 'o', 'u'])


def solve_problem(s, length):
    seen = set()
    names = 0
    num_of_consonants = 0
    for i, c in enumerate(s):
        if c in vowels:
            num_of_consonants = 0
        else:
            num_of_consonants += 1

        if num_of_consonants >= length:
            for k in xrange(len(s[:i + 1]) - length + 1):
                name = (k, s[k:i +1])
                if len(name[1]) >= length and name not in seen:
                    seen.add(name)
                    names += 1

                for j in xrange(len(s[i + 1:]) + 1):
                    name = (k, s[k:i + 1 + j])
                    if len(name[1]) >= length and name not in seen:
                        seen.add(name)
                        names += 1

    return names

if __name__ == '__main__':
    num_of_cases = int(sys.stdin.readline().strip())
    for i in xrange(1, num_of_cases + 1):
        s, length = sys.stdin.readline().strip().split()
        print "Case #{0}: {1}".format(i, solve_problem(s, int(length)))
