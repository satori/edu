"""
Google Code Jam Practice Problems (2008) Problem A.
Usage:
    python a.py < input.txt > output.txt
"""
import sys
import math

def solve_problem(number, source_lang, target_lang):
    source_base = len(source_lang)
    target_base = len(target_lang)

    source_digits = {}
    for i, c in enumerate(source_lang):
        source_digits[c] = i

    target_digits = []
    for c in target_lang:
        target_digits.append(c)

    base10 = 0
    for i, c in enumerate(reversed(number)):
        base10 += source_digits[c] * int(math.pow(source_base, i))

    remainders = []

    while base10 > 0:
        remainders.append(base10 % target_base)
        base10 /= target_base

    if not remainders:
        remainders = [0]

    return ''.join(map(lambda c: target_digits[c], reversed(remainders)))

if __name__ == "__main__":
    num_of_cases = int(sys.stdin.readline())
    for i in xrange(1, num_of_cases + 1):
        number, source_lang, target_lang = sys.stdin.readline().split()
        print 'Case #{0}: {1}'.format(i, solve_problem(number, source_lang, target_lang))
