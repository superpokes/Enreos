#!/usr/bin/env python3
import sys

class Pizza(object):
    def __init__(self, width, height, min_ings, max_cells):
        super(Pizza, self).__init__()
        self.width = width
        self.height = height
        self.min_ings = min_ings
        self.max_cells = max_cells
        self.cells = []

    def __str__(self):
        st = (str(self.height) + ' ' + str(self.width) + ' ' +
              str(self.min_ings) + ' ' + str(self.max_cells) + '\n')
        for line in self.cells:
            for cell in line:
                st += cell
            st += '\n'
        return st


def parse_pizza(i_file):
    params = i_file.readline().split(' ')
    pizza = Pizza(int(params[1]), int(params[0]), int(params[2]), int(params[3]))
    for row in iter(lambda: i_file.readline(), ""):
        tmp = []
        for ingredient in row:
            tmp.append(ingredient)
        tmp.pop()
        pizza.cells.append(tmp)
    return pizza


def main():
    if len(sys.argv) == 1:
        filename = input("What's that filename?")
        i_file = open(filename + ".in")
    else:
        filename = sys.argv[1]
        i_file = open(filename + ".in")

        pizza = parse_pizza(i_file)

        print(str(pizza))


if __name__ == '__main__':
    main()
