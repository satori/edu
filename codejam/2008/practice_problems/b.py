# Copyright (C) 2013-2014 by Maxim Bublis <b@codemonkey.ru>
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
Google Code Jam Practice Problems (2008) Problem B.
Usage:
    python b.py < input.txt > output.txt
"""
import collections
import itertools
import sys

CAN_WALK_NORTH = 0x01
CAN_WALK_SOUTH = 0x02
CAN_WALK_WEST = 0x04
CAN_WALK_EAST = 0x08

WALK_NORTH = (0, 1)
WALK_SOUTH = (0, -1)
WALK_WEST = (-1, 0)
WALK_EAST = (1, 0)


def walk_maze(maze, path, position, direction):
    x, y = position
    for c in path:
        cur = (x, y)
        if c == 'R':
            direction = (direction[1], -direction[0])
        if c == 'L':
            direction = (-direction[1], direction[0])
        if c == 'W':
            if direction == WALK_NORTH:
                room = CAN_WALK_NORTH
            elif direction == WALK_SOUTH:
                room = CAN_WALK_SOUTH
            elif direction == WALK_WEST:
                room = CAN_WALK_WEST
            elif direction == WALK_EAST:
                room = CAN_WALK_EAST

            maze[cur] |= room

            x += direction[0]
            y += direction[1]

    return direction, cur


def solve_problem(entrance_to_exit, exit_to_entrance):
    maze = collections.defaultdict(lambda: 0)

    direction, position = walk_maze(maze, entrance_to_exit[1:], (0, -1), (0, -1))
    walk_maze(maze, exit_to_entrance[1:], position, (-direction[0], -direction[1]))

    sort_by = lambda ((x, y), room): (-y, x)
    group_by = lambda ((x, y), room): y

    answer = []
    for key, group in itertools.groupby(sorted(maze.items(), key=sort_by), group_by):
        answer.append(''.join(['{0:x}'.format(room[1]) for room in group]))

    return '\n'.join(answer)


if __name__ == "__main__":
    num_of_cases = int(sys.stdin.readline())
    for i in xrange(1, num_of_cases + 1):
        entrance_to_exit, exit_to_entrance = sys.stdin.readline().split()
        print 'Case #{0}:\n{1}'.format(i, solve_problem(entrance_to_exit, exit_to_entrance))
