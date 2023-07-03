#!/usr/bin/env python

import datetime
import json
import subprocess
from html import escape

data = {}

today = datetime.date.today().strftime("%Y-%m-%d")

next_week = (datetime.date.today() +
             datetime.timedelta(days=10)).strftime("%Y-%m-%d")

output = subprocess.check_output("khal list now " + next_week + " --format \"{start-end-time-style} {title}\"", shell=True).decode("utf-8")

lines = output.split("\n")
new_lines = []
for line in lines:
    clean_line = escape(line).split(" ::")[0]
    if len(clean_line) and not clean_line[0] in ['0', '1', '2']:
        clean_line = "\n<b>"+clean_line+"</b>"
    new_lines.append(clean_line)
output = "\n".join(new_lines).strip()

if today in output:
    data['text'] = " " + output.split('\n')[1]
else:
    data['text'] = ""

data['tooltip'] = output

print(json.dumps(data))
