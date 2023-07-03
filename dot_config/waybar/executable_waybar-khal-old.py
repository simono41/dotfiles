#!/usr/bin/env python

import subprocess
import datetime
import json
from html import escape

data = {}

today = datetime.date.today().strftime("%Y-%m-%d")

next_week = (datetime.date.today() +
             datetime.timedelta(days=10)).strftime("%Y-%m-%d")

output = subprocess.check_output("khal list now "+next_week, shell=True)
output = output.decode("utf-8")

lines = output.split("\n")
new_lines = []
for line in lines:
    if len(line) and line[0].isalpha():
        line = "\n<b>"+line+"</b>"
    new_lines.append(line)
output = "\n".join(new_lines).strip()

if today in output:
    data['text'] = " " + output.split('\n')[1]
else:
    data['text'] = ""

data['tooltip'] = output

print(json.dumps(data))
