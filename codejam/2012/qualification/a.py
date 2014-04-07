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

hints = {
    'ejp mysljylc kd kxveddknmc re jsicpdrysi': 'our language is impossible to understand',
    'rbcpc ypc rtcsra dkh wyfrepkym veddknkmkrkcd': 'there are twenty six factorial possibilities',
    'de kr kd eoya kw aej tysr re ujdr lkgc jv': 'so it is okay if you want to just give up',
}

mapping = {'q': 'z', 'z': 'q'}

for k, v in hints.items():
    for from_char, to_char in zip(k, v):
        mapping[from_char] = to_char

def solve_problem():
    number_of_cases = int(sys.stdin.readline())
    for i in xrange(1, number_of_cases + 1):
        case = sys.stdin.readline().strip()
        translated = ''.join(map(lambda c: mapping.get(c, c), case))
        sys.stdout.write('Case #{0}: {1}\n'.format(i, translated))

if __name__ == '__main__':
    solve_problem()
