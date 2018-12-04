import options
import strutils
import tables

var lines: seq[string]
var fronts = initTable[string, seq[string]]()
var backs = initTable[string, seq[string]]()


proc oneDiff(a, b: string): Option[string] =
  var match = ""
  var diffs = 0

  for i, c in a:
    if b[i] == c:
      match.add(c)
    elif diffs < 1:
      diffs = 1
    else:
      return
  
  if diffs == 1:
    return some(match)
  else:
    return


proc findMatch(line: string) : Option[string] =
  for cand in fronts[line[0..<13]]:
    if cand == line:
      continue
    result = oneDiff(line, cand)
    if result.isSome:
      return
      
  for cand in backs[line[13..^1]]:
    if cand == line:
      continue
    result = oneDiff(line, cand)
    if result.isSome:
      return


# read file, find the front and back parts
for line in "input.txt".lines:
  lines.add(line)
  let f = line[0..<13]
  let b = line[13..^1]
  if f in fronts:
    fronts[f].add(line)
  else:
    fronts[f] = @[line]
  
  if b in backs:
    backs[b].add(line)
  else:
    backs[b] = @[line]


for line in lines:
  let res = findMatch(line)
  if res.isSome:
    echo res.get
    break
