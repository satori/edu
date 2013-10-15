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

def walk_maze(maze, path, x, y, direction):
    cur = (x, y)
    for c in path:
        cur = (x, y)
        room = 0
        if c == 'R':
            direction = (direction[1], -direction[0])
        if c == 'L':
            direction = (-direction[1], direction[0])
        if c == 'W':
            if direction == WALK_NORTH:
                room |= CAN_WALK_NORTH
            elif direction == WALK_SOUTH:
                room |= CAN_WALK_SOUTH
            elif direction == WALK_WEST:
                room |= CAN_WALK_WEST
            elif direction == WALK_EAST:
                room |= CAN_WALK_EAST

            maze[cur] |= room

            x += direction[0]
            y += direction[1]

    return direction, cur


def solve_problem(entrance_to_exit, exit_to_entrance):
    maze = collections.defaultdict(lambda: 0)

    x = 0
    y = 0

    direction, cur = walk_maze(maze, entrance_to_exit[1:], 0, -1, (0, -1))
    walk_maze(maze, exit_to_entrance[1:], cur[0], cur[1], (-direction[0], -direction[1]))

    keyfunc = lambda room: room[0][1]

    answer = []
    for key, group in itertools.groupby(sorted(maze.items(), key=keyfunc, reverse=True), keyfunc):
        answer.append(''.join(map(lambda room: '{0:x}'.format(room[1]), sorted(group))))

    return '\n'.join(answer)

if __name__ == "__main__":
    num_of_cases = int(sys.stdin.readline())
    for i in xrange(1, num_of_cases + 1):
        entrance_to_exit, exit_to_entrance = sys.stdin.readline().split()
        print 'Case #{0}:\n{1}'.format(i, solve_problem(entrance_to_exit, exit_to_entrance))
