# -*- coding: utf-8 -*-
"""
fixbib.py

Pre-processes bibliography files exported by Mendeley to remove unused
entries and using the 'annote' field to specify custom bibtex entries.

Created on Wed Dec 30 18:40:06 2015

@author: Gonçalo
"""

import sys
from itertools import ifilter, chain

fieldsep = '='
noopsort = '@preamble{"\\newcommand{\\noopsort}[1]{}"}\n'
suppressfields = ['file','abstract','doi','issn','pmid','keywords',
                  'isbn','eprint','arxivId','archivePrefix']

def parsefield(line):
    name,sep,content = line.partition(fieldsep)
    if sep != fieldsep:
        return '',''
    return name.strip(),content
    
def filterline(line):
    name,content = parsefield(line)
    if name in suppressfields:
        return False
    return True

bracketmap = {'{':1,'}':-1}
def maplines(lines):
    bracketcount = 0
    for line in lines:
        name,content = parsefield(line)
        if name == 'annote':
            line = content.strip(' {')
            bracketcount = 1
        if bracketcount > 0:
            bracketcount += sum((bracketmap.get(c,0) for c in line))
            if bracketcount <= 0:
                line,ending = line.rsplit('},',1)
                line += ending
                bracketcount = 0
        yield line

if len(sys.argv) != 2:
    print "usage: fixbib bibliography.bib"
    
filename = sys.argv[1]
with open(filename) as f:
    lines = f.readlines()

lines = ifilter(filterline,lines)
lines = maplines(lines)

# declare noopsort
lines = chain((noopsort,),lines)

with open(filename,'w') as f:
    f.writelines(lines)