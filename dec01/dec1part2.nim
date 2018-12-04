import strutils
import sets
import options

type 
  SearchResult = tuple[lastResult: int, duplicateFound: bool]


proc findDup(start: int, seen: var HashSet[int], filename: string): SearchResult =
  result.lastResult = start
  result.duplicateFound = false
  for line in filename.lines:
    result.lastResult += line.parseInt
    if contains(seen, result.lastResult):
      result.duplicateFound = true
      return
    else:
      incl(seen, result.lastResult)


const filename = "input.txt"
var freqs = initSet[int]()
var sr = findDup(0, freqs, filename)
while not sr.duplicateFound:
  sr = findDup(sr.lastResult, freqs, filename)

echo sr.lastResult
