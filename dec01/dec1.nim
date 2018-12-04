import strutils

var result = 0

for line in "input.txt".lines:
  let i = line.parseInt
  result = result + i

echo result
