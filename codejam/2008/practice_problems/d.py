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
Google Code Jam Practice Problems (2008) Problem D.
Usage:
    python d.py < input.txt > output.txt
"""
import math
import sys


HOME = (0, 0)


def solve_problem(items, price_of_gas, stores):

    def memoized(func):
        cache = {}
        def wrapped(*args):
            if not args in cache:
                cache[args] = func(*args)
            return cache[args]
        return wrapped

    @memoized
    def gas_cost(pos, dest):
        pos_x, pos_y = pos
        dest_x, dest_y = dest

        return math.sqrt((dest_x - pos_x) ** 2 + (dest_y - pos_y) ** 2) * price_of_gas

    @memoized
    def find_min_cost(pos, items, perishing):
        if not items and not perishing:
            return gas_cost(pos, HOME)

        min_cost = float('inf')

        for item, perishable in items:
            remaining = tuple((i, p) for i, p in items if i != item)

            for store in stores:
                if not item in store['items'] or (perishing and pos != store['pos']):
                    continue

                cost = gas_cost(pos, store['pos']) + store['items'][item]

                if perishable or perishing:
                    cost += min(gas_cost(store['pos'], HOME) + find_min_cost(HOME, remaining, False),
                                find_min_cost(store['pos'], remaining, True))
                else:
                    cost += find_min_cost(store['pos'], remaining, False)

                min_cost = min(min_cost, cost)

        return min_cost

    return find_min_cost(HOME, items, False)


if __name__ == "__main__":
    num_of_cases = int(sys.stdin.readline())
    for i in xrange(1, num_of_cases + 1):
        num_items, num_stores, price_of_gas = map(int, sys.stdin.readline().split())

        items = tuple((item.rstrip("!"), item.endswith("!")) for item in sys.stdin.readline().split())

        stores = []
        for k in xrange(num_stores):
            s = sys.stdin.readline().split()
            x_pos, y_pos = map(int, s[:2])
            stores.append({
                'pos': (x_pos, y_pos),
                'items': {x.split(":")[0]: int(x.split(":")[1]) for x in s[2:]},
            })

        stores = tuple(stores)

        print "Case #{0}: {1:9.7f}".format(i, solve_problem(items, price_of_gas, stores))
