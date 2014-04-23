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
Google Code Jam 2008 Beta Problem B
Usage:
    python b.py < input.txt > output.txt
"""
import sys


def memoized(func):
    _cache = {}
    def wrapped(*args):
        if not args in _cache:
            _cache[args] = func(*args)
        return _cache[args]
    return wrapped


@memoized
def longest_consequence(goods, guesses):
    if not goods or not guesses:
        return ()

    sub_longest_consequence = max(longest_consequence(goods[:-1], guesses),
                                  longest_consequence(goods, guesses[:-1]),
                                  key=lambda x: (len(x), sorted(x)))

    if goods[-1] == guesses[-1]:
        return sub_longest_consequence + (goods[-1],)

    return sub_longest_consequence


def solve_problem(goods, guesses):
    return sorted(set(goods) - set(longest_consequence(goods, guesses)))


if __name__ == "__main__":
    num_of_cases = int(sys.stdin.readline().strip())

    for i in xrange(1, num_of_cases + 1):
        goods = tuple(sys.stdin.readline().strip().split())
        raw_prices = map(int, sys.stdin.readline().strip().split())
        prices = {goods[i]: price for i, price in enumerate(raw_prices)}
        guesses = tuple(sorted(goods, key=lambda guess: (prices[guess], guess)))

        print "Case #{0}: {1}".format(i, ' '.join(solve_problem(goods, guesses)))
