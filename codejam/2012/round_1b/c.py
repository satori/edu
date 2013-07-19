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
