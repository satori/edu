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
Google Code Jam 2008 Beta Problem A
Usage:
    python a.py < input.txt > output.txt
"""
import math
import sys


def calc_length(p1, p2):
    diff_x = p1[0] - p2[0]
    diff_y = p1[1] - p2[1]
    return math.sqrt(diff_x ** 2 + diff_y ** 2)


def calc_angle(a, b, c):
    return math.degrees(math.acos((b ** 2 + c ** 2 - a ** 2) / (2 * b * c)))


def is_right(angle):
    return is_error(angle - 90.0)


def is_error(value):
    return abs(value) < 1e-13


def solve_problem(a, b, c):
    ab = calc_length(a, b)
    ac = calc_length(a, c)
    bc = calc_length(b, c)

    if is_error(ab - ac - bc) or is_error(ac - ab - bc) or is_error(bc - ab - ac):
        return "not a triangle"

    if ab == ac or ab == bc or ac == bc:
        by_sides = "isosceles"
    else:
        by_sides = "scalene"

    angle1 = calc_angle(ab, ac, bc)
    angle2 = calc_angle(ac, bc, ab)
    angle3 = 180.0 - angle1 - angle2

    if is_right(angle1) or is_right(angle2) or is_right(angle3):
        by_angle = "right"
    elif angle1 > 90.0 or angle2 > 90.0 or angle3 > 90.0:
        by_angle = "obtuse"
    else:
        by_angle = "acute"

    return "{0} {1} triangle".format(by_sides, by_angle)


if __name__ == "__main__":
    num_of_cases = int(sys.stdin.readline().strip())

    for i in xrange(1, num_of_cases + 1):

        coords = map(int, sys.stdin.readline().strip().split())

        p1 = coords[:2]
        p2 = coords[2:4]
        p3 = coords[4:]

        print "Case #{0}: {1}".format(i, solve_problem(p1, p2, p3))
