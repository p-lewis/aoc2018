import strutils
import re

type Claim = tuple[id, left, top, width, height: int]

type Row = array[1000, uint8]

proc parseClaim(s: string): Claim =
  let pattern = re(r"\#(\d+) @ (\d+),(\d+): (\d+)x(\d+)")
  var groups: array[5, string]

  let matched = match(s, pattern, groups)
  assert matched

  result.id = groups[0].parseInt
  result.left = groups[1].parseInt
  result.top = groups[2].parseInt
  result.width = groups[3].parseInt
  result.height = groups[4].parseInt

var allClaims: array[1000, Row]
var candidates: seq[Claim] = @[] 


for line in "input.txt".lines:
  var claim = parseClaim(line)
  # echo line
  var conflict = false
  for row in claim.top..<(claim.top + claim.height):
    for col in claim.left..<(claim.left + claim.width):
      if allClaims[row][col] < 2:
        allClaims[row][col] += 1
      if allClaims[row][col] > 1u:
        conflict = true
  if not conflict:
    candidates.add(claim)


# check results 
proc hasConflict(claim: Claim): bool =
    for row in claim.top..<(claim.top + claim.height):
      for col in claim.left..<(claim.left + claim.width):
        if allClaims[row][col] > 1u:
          return true
    return false

for claim in candidates:
  if not hasConflict(claim):
    echo claim
