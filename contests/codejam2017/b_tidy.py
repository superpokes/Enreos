#!/usr/bin/env python3

# Tatiana likes to keep things tidy. Her toys are sorted from smallest to
# largest, her pencils are sorted from shortest to longest and her computers
# from oldest to newest. One day, when practicing her counting skills, she
# noticed that some integers, when written in base 10 with no leading zeroes,
# have their digits sorted in non-decreasing order. Some examples of this are
# 8, 123, 555, and 224488. She decided to call these numbers tidy. Numbers that
# do not have this property, like 20, 321, 495 and 999990, are not tidy.
#
# She just finished counting all positive integers in ascending order from 1
# to N. What was the last tidy number she counted?

def digits(n):
    dig = []
    while n != 0:
        dig.append(n % 10)
        n = n // 10
    return dig

def nonincreasing(xs):
    for i in range(len(xs) - 1):
        if xs[i + 1] > xs[i]:
            return i + 1
    return -1

def fromdigits(xs):
    s = 0
    for i in range(len(xs)):
        s += xs[i] * 10 ** i
    return s

def lasttidy(n):
    while True:
        d = digits(n)
        l = len(d)
        i = nonincreasing(d)
        if i == -1:
            return n
        else:
            d = ([9] * i) + [d[i] - 1] + d[i + 1:]
            n = fromdigits(d)

def main():
    cases = int(input())
    for c in range(1, cases + 1):
        n = int(input())
        print('Case #{}: {}'.format(c, lasttidy(n)))

if __name__ == '__main__':
    main()
