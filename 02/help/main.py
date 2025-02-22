#!/bin/python3

import sys
from collections import Counter, defaultdict
from copy import deepcopy
from heapq import heappop, heappush
from typing import List, Set, Tuple

FILE = sys.argv[1] if len(sys.argv) > 1 else "../input.txt"

safe = False

def read_lines_to_list() -> List[str]:
    lines: List[str] = []
    with open(FILE, "r", encoding="utf-8") as f:
        for line in f:
            line = line.strip()
            lines.append(line)

    return lines


def part_one():
    lines = read_lines_to_list()
    answer = 0

    for l in lines:
        row = [int(a) for a in l.split()]

        is_increasing = None
        for i in range(0, len(row) - 1):
            a = row[i]
            b = row[i + 1]

            if a > b:
                if is_increasing is None:
                    is_increasing = False
                elif is_increasing:
                    break
            else:
                if is_increasing is None:
                    is_increasing = True
                elif not is_increasing:
                    break

            diff = abs(a - b)
            if diff < 1 or diff > 3:
                break
        else:
            answer += 1

    print(f"Part 1: {answer}")


def part_two():
    lines = read_lines_to_list()
    answer = 0

    for l in lines:
        row = [int(a) for a in l.split()]

        is_increasing = None
        for i in range(0, len(row) - 1):
            a = row[i]
            b = row[i + 1]

            if a > b:
                if is_increasing is None:
                    is_increasing = False
                elif is_increasing:
                    break
            else:
                if is_increasing is None:
                    is_increasing = True
                elif not is_increasing:
                    break

            diff = abs(a - b)
            if diff < 1 or diff > 3:
                break
        else:
            answer += 1
            continue

        global safe

        # Brute force, try it with each number removed
        for j in range(0, len(row)):

            safe = False
            new_row = row[:j] + row[j + 1:]
            is_increasing = None
            for i in range(0, len(new_row) - 1):
                a = new_row[i]
                b = new_row[i + 1]

                if a > b:
                    if is_increasing is None:
                        is_increasing = False
                    elif is_increasing:
                        break
                else:
                    if is_increasing is None:
                        is_increasing = True
                    elif not is_increasing:
                        break

                diff = abs(a - b)
                if diff < 1 or diff > 3:
                    break
            else:
                safe = True
                answer += 1
                break

        if not safe:
            [f.write(f"{i},") for i in row]
            f.write("\n")



    print(f"Part 2: {answer}")


part_one()
with open("unsafe_python.txt", "w+") as f:
    part_two()
