#!/usr/bin/env python

"""
A script to take sets of linked data statements
and generate a Graphviz DOT file for visualization.
"""

import fileinput

# Store a list of blocks, each of which is a dictionary
# with a 'name' string, and zero or more predicate keys
# each with a list of strings as its value.
blocks = []
block = {}
name = None

def rename(name):
  return name.replace(" ", "_")

# Step through the input line-by-line, creating blocks
for line in fileinput.input():
  # Blank line
  if line.strip() == "":
    pass
  # Indented line
  elif line.startswith(" "):
    if not name:
      pass
    key, value = line.split(": ", 2)
    if not key:
      pass
    key = key.strip()
    if not value:
      pass
    value = value.strip()
    if not key in block:
      block[key] = []
    block[key].append(value)

  # New block
  else:
    name = line.strip()
    if len(block.keys()) is not 0:
      blocks.append(block)
    block = {'name': name}

if len(block.keys()) is not 0:
  blocks.append(block)

# Start generating the DOT file
print '''digraph G {
  graph[rankdir=BT, center=true, margin=0]
  node [shape = "record"]

  // Nodes'''

# Add a node for each block, with its label.
for block in blocks:
  if not 'type' in block:
    continue
  if block['type'][0].startswith('owl:'):
    continue
  print '  %s [label="{%s|%s}"];' % (
    rename(block['name']),
    "\n".join(block['type']),
    block['name']
  )

# Configure the relations to show, and handle some special cases
print '''
  // Relations'''

relations = [
  'has part',
  'part of',
  'executes',
  'device',
  'setting',
  'format',
  'reagent',
  'input',
  'output'
]

reverse = {
    'executes'
    }

default_label = 'label=" %s " style=dotted'
labels = {
  'executes': default_label + ' dir=back',
  'has part': 'style=dashed',
  'input': 'dir=back',
  'output': '',
  'part of': 'style=dashed',
  'preceded by': 'constraint=false'
}

# Add an edge for each relation, handling some special cases
for block in blocks:
  if not 'type' in block:
    continue
  if block['type'][0].startswith('owl:'):
    continue
  for key in relations:
    if key in block.keys():
      if key == 'has part' and block[key]:
        print '  {rank=same;\n   ' + ' ->\n   '.join(rename(n) for n in block[key]) + ' [style=invis];\n  }'
      if key in labels:
        edge = labels[key]
      else:
        edge = default_label
      if edge.count('%s') > 0:
        edge = edge % key
      for value in block[key]:
        from_node = rename(block['name'])
        to_node = rename(value)
        if key in reverse:
          temp = from_node
          from_node = to_node
          to_node = temp
        print '  %s -> %s [%s];' % (from_node, to_node, edge)
    print

print '}'


