#!/usr/bin/env python
from pandocfilters import walk, stringify, toJSONFilter, Str

"""
Pandoc filter that:

- writes all **strong** terms to new-terms.csv
- writes all linked OBO terms to import-terms.csv

See: https://github.com/jgm/pandocfilters
"""

obo = "http://purl.obolibrary.org/obo/"
import_terms = open("imports/obo-terms.txt", "w")
new_terms = open("new-terms.txt", "w")

def find(key, val, fmt, meta):
    if key == 'Strong':
        new_terms.write(stringify(val) + "\n")
    if key == 'Link' and str(val[1][0]).startswith(obo):
        import_terms.write(str(val[1][0]) + " # " + stringify(val) + "\n")

if __name__ == "__main__":
    toJSONFilter(find)

