#!/usr/bin/env python3

# A certain bathroom has N + 2 stalls in a single row; the stalls on the left
# and right ends are permanently occupied by the bathroom guards. The other N
# stalls are for users.
#
# Whenever someone enters the bathroom, they try to choose a stall that is as
# far from other people as possible. To avoid confusion, they follow
# deterministic rules: For each empty stall S, they compute two values LS and
# RS, each of which is the number of empty stalls between S and the closest
# occupied stall to the left or right, respectively. Then they consider the
# set of stalls with the farthest closest neighbor, that is, those S for which
# min(LS, RS) is maximal. If there is only one such stall, they choose it;
# otherwise, they choose the one among those where max(LS, RS) is maximal. If
# there are still multiple tied stalls, they choose the leftmost stall among
# those.
#
# K people are about to enter the bathroom; each one will choose their stall
# before the next arrives. Nobody will ever leave.
#
# When the last person chooses their stall S, what will the values of
# max(LS, RS) and min(LS, RS) be?

# Version 1: inefficient
# def stall(n, k):
#     stalls = [True] + [False] * n + [True]
#
#     for ppl in range(k):
#         max_lr, min_lr, best = -1, -1, -1
#         l, r = 0, 0
#
#         for i in range(n + 1):
#             if stalls[i]:
#                 l, r = -1, 0
#                 while not stalls[i + r + 1]:
#                     r += 1
#             else:
#                 l += 1
#                 r -= 1
#                 if min(l, r) > min_lr or (min(l, r) == min_lr and max(l, r) > max_lr):
#                     max_lr = max(l, r)
#                     min_lr = min(l, r)
#                     best = i
#
#         stalls[best] = True
#
#     return max_lr, min_lr

# Version 2: inefficient
# def stall(n, k):
#     # Ls and Rs distances
#     stalls = [(i, n - i - 1) for i in range(n)]
#     # Unoccupied stalls
#     free = set(range(n))
#
#     # Place everyone except the last person
#     for _ in range(k - 1):
#         # Find the best stall
#         minlr, maxlr, newpos = -1, -1, -1
#         for p in free:
#             l, r = stalls[p]
#             if min(l, r) > minlr or (min(l, r) == minlr and max(l, r) > maxlr) or (max(l, r) == maxlr and p < newpos):
#                 newpos = p
#                 minlr, maxlr = min(l, r), max(l, r)
#
#         print('min {}, max {}'.format(minlr, maxlr))
#
#         # Place them
#         free.remove(newpos)
#
#         # Calculate new distances
#         i = newpos - 1
#         r = 0
#         while i in free:
#             l, _ = stalls[i]
#             stalls[i] = l, r
#             r += 1
#             i -= 1
#
#         i = newpos + 1
#         l = 0
#         while i in free:
#             _, r = stalls[i]
#             stalls[i] = l, r
#             l += 1
#             i += 1
#
#     # Place the last person
#     minlr, maxlr, newpos = -1, -1, -1
#     for p in free:
#         l, r = stalls[p]
#         if min(l, r) > minlr or (min(l, r) == minlr and max(l, r) > maxlr) or (max(l, r) == maxlr and p < newpos):
#             newpos = p
#             minlr, maxlr = min(l, r), max(l, r)
#
#     return maxlr, minlr

# Version 3: inefficient
def stall(n, k):
    groups = [n]

    for _ in range(k - 1):
        new = 0
        for i in range(len(groups)):
            if groups[i] > groups[new]:
                new = i
        if groups[new] % 2 == 0:
            g = groups[new]
            del groups[new]
            if g == 2:
                groups.insert(new, 1)
            else:
                groups.insert(new, g // 2)
                groups.insert(new, g // 2 - 1)
        else:
            g = groups[new]
            del groups[new]
            if g != 1:
                groups.insert(new, g // 2)
                groups.insert(new, g // 2)

    new = 0
    for i in range(len(groups)):
        if groups[i] > groups[new]:
            new = i

    if groups[new] % 2 == 0:
        if groups[new] == 2:
            return 1, 0
        else:
            return groups[new] // 2, groups[new] // 2 - 1
    else:
        if g == 1:
            return 0, 0
        else:
            return groups[new] // 2, groups[new] // 2

def main():
    cases = int(input())
    for c in range(1, cases + 1):
        [n, k] = [int(i) for i in input().split()]
        max_lr, min_lr = stall(n, k)
        print('Case #{}: {} {}'.format(c, max_lr, min_lr))

if __name__ == '__main__':
    main()
