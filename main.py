#!/usr/bin/env python3

from jinja2 import Template
import os
import subprocess

rendered_text = Template(open('davmail.properties.j2').read()).render(env=os.environ)

with open('davmail.properties', 'w') as f:
    f.write(rendered_text)

# run it
command = ["davmail", "davmail.properties"]
subprocess.Popen(command)
