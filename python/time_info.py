#!/usr/bin/env python

import sys
import time

def main():
    if len(sys.argv) > 1:
        itime = int(sys.argv[1])
    else:
        itime = 100

    ticks = 0
    with open('timeinfo.txt', 'w') as f:
        for _ in range(1000):
            f.write('{0} ticks - {1} mod\n'.format(ticks, ticks % itime))
            ticks += 17

if __name__ == '__main__':
    main()
