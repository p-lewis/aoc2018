import tables

type BoxCount = tuple[matchTwo: bool, matchThree: bool]

proc examineBox(row: string) : BoxCount =
    result = (matchTwo: false, matchThree: false)

    var counts = initCountTable[char]()
    for c in row:
        if c in counts:
            counts.inc(c)
        else:
            counts[c] = 1

    for v in counts.values:
        if v == 2:
            result.matchTwo = true
        elif v == 3:
            result.matchThree = true


var c2 = 0
var c3 = 0

for line in "input.txt".lines:
    let bc = examineBox(line)
    if bc.matchTwo:
        c2 += 1
    if bc.matchThree:
        c3 += 1

echo $(c2*c3)
