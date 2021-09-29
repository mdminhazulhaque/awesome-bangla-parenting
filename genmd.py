#!/usr/bin/python3

import json

with open("_data/parenting.json", "r") as fp:
    data = json.load(fp)

for category in data:
    print(F"# {category}")
    print()
    for site in data[category]:
        url = data[category][site]
        print(F"* [{site}]({url})")
    print()
