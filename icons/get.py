import argparse
import pathlib
import re

class_re = re.compile(r"\.nf-([a-z\-_0-9]+):before {")
codepoint_re = re.compile(r"content: \"\\([a-z0-9]{4})\";")

def parse_css(css_path):
    with open(css_path) as css:
        for line in css:
            if m := class_re.match(line):
                codepoint = int(codepoint_re.match(next(css).strip()).group(1), 16)
                yield m.group(1), codepoint


parser = argparse.ArgumentParser()
parser.add_argument('css', type=pathlib.Path)
parser.add_argument('-o', type=pathlib.Path, dest='nix', default="./nerd.nix")
parser.add_argument('-C', type=pathlib.Path, dest='dir')

args = parser.parse_args()

with open(args.nix, 'w') as nixfile:
    nixfile.write("{\n")
    for icon, codepoint in parse_css(args.css):
        nixfile.write(f"  {icon} = {{char = \"{chr(codepoint)}\"; icon = {args.dir}/share/nerd-icons/{codepoint:x}.svg; }};\n")
    nixfile.write("}\n")
