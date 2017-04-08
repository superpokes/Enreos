#!/usr/bin/env python3

# Last year, the Infinite House of Pancakes introduced a new kind of pancake.
# It has a happy face made of chocolate chips on one side (the "happy side"),
# and nothing on the other side (the "blank side").
#
# You are the head cook on duty. The pancakes are cooked in a single row over a
# hot surface. As part of its infinite efforts to maximize efficiency, the House
# has recently given you an oversized pancake flipper that flips exactly K
# consecutive pancakes. That is, in that range of K pancakes, it changes every
# happy-side pancake to a blank-side pancake, and vice versa; it does not change
# the left-to-right order of those pancakes.
#
# You cannot flip fewer than K pancakes at a time with the flipper, even at the
# ends of the row (since there are raised borders on both sides of the cooking
# surface). For example, you can flip the first K pancakes, but not the first
# K - 1 pancakes.
#
# Your apprentice cook, who is still learning the job, just used the
# old-fashioned single-pancake flipper to flip some individual pancakes and then
# ran to the restroom with it, right before the time when customers come to
# visit the kitchen. You only have the oversized pancake flipper left, and you
# need to use it quickly to leave all the cooking pancakes happy side up, so
# that the customers leave feeling happy with their visit.
#
# Given the current state of the pancakes, calculate the minimum number of uses
# of the oversized pancake flipper needed to leave all pancakes happy side up,
# or state that there is no way to do it.

f = lambda p: '+' if p is '-' else '-'
flip = lambda p, i, j: p[:i] + ''.join([f(c) for c in p[i:j]]) + p[j:]
def oversized(pancakes, size):
    count = 0

    while True:
        i = pancakes.find('-')
        if i == -1:
            return count
        elif i + size > len(pancakes):
            return None
        pancakes = flip(pancakes, i, i + size)
        count += 1


def main():
    cases = int(input())
    for i in range(1, cases + 1):
        [pancakes, size] = input().split()
        res = oversized(pancakes, int(size))
        if res is None:
            print('Case #{}: IMPOSSIBLE'.format(i))
        else:
            print('Case #{}: {}'.format(i, res))

if __name__ == '__main__':
    main()
