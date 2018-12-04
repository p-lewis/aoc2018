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


for line in "input.txt".lines:
  var claim = parseClaim(line)
  # echo line
  for row in claim.top..<(claim.top + claim.height):
    for col in claim.left..<(claim.left + claim.width):
      # echo "$1, $2".format(row, col)
      if allClaims[row][col] < 2:
        allClaims[row][col] += 1

# check results 

var conflicts: uint = 0

for row in allClaims:
  for col in row:
    if col > 1u:
      conflicts += 1

echo "Conflicts: $1".format(conflicts)
