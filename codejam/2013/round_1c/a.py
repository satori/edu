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
