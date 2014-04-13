// Copyright (C) 2014 by Maxim Bublis <b@codemonkey.ru>
//
// Permission is hereby granted, free of charge, to any person obtaining
// a copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including
// without limitation the rights to use, copy, modify, merge, publish,
// distribute, sublicense, and/or sell copies of the Software, and to
// permit persons to whom the Software is furnished to do so, subject to
// the following conditions:
//
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
// LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
// OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

package main

import (
	"bufio"
	"bytes"
	"fmt"
	"os"
)

type Pos struct {
	x int
	y int
}

type Minefield [50]uint64

var Impossible Minefield

func iterNeighbors(pos Pos, rows int, columns int) []Pos {
	neighbors := make([]Pos, 0)

	if pos.y > 0 {
		if pos.x > 0 {
			neighbors = append(neighbors, Pos{pos.x - 1, pos.y - 1})
		}
		neighbors = append(neighbors, Pos{pos.x, pos.y - 1})
		if pos.x+1 < columns {
			neighbors = append(neighbors, Pos{pos.x + 1, pos.y - 1})
		}
	}

	if pos.x > 0 {
		neighbors = append(neighbors, Pos{pos.x - 1, pos.y})
	}

	if pos.x+1 < columns {
		neighbors = append(neighbors, Pos{pos.x + 1, pos.y})
	}

	if pos.y+1 < rows {
		if pos.x > 0 {
			neighbors = append(neighbors, Pos{pos.x - 1, pos.y + 1})
		}

		neighbors = append(neighbors, Pos{pos.x, pos.y + 1})

		if pos.x+1 < columns {
			neighbors = append(neighbors, Pos{pos.x + 1, pos.y + 1})
		}
	}

	return neighbors
}

type CacheId struct {
	pos   Pos
	cells Minefield
}

type Cache map[CacheId]Minefield

func tryToClick(_cache Cache, pos Pos, cells Minefield, rows int, columns int, remaining int) Minefield {
	cacheId := CacheId{pos, cells}

	if res, ok := _cache[cacheId]; ok {
		return res
	}

	if remaining == 0 {
		return cells
	}

	var newCells Minefield

	for i := 0; i < rows; i++ {
		newCells[i] = cells[i]
	}

	opened := make([]Pos, 0)

	for _, new_pos := range iterNeighbors(pos, rows, columns) {
		if newCells[new_pos.y]&(1<<uint8(new_pos.x)) == 0 {
			newCells[new_pos.y] |= (1 << uint8(new_pos.x))
			opened = append(opened, new_pos)
		}
	}

	if len(opened) == remaining {
		_cache[cacheId] = newCells
		return newCells
	}

	if len(opened) > remaining {
		_cache[cacheId] = Impossible
		return Impossible
	}

	if len(opened) < remaining {
		for _, new_pos := range opened {
			solution := tryToClick(_cache, new_pos, newCells, rows, columns, remaining-len(opened))
			if solution != Impossible {
				_cache[cacheId] = solution
				return solution
			}
		}
	}

	_cache[cacheId] = Impossible

	return Impossible
}

func solveProblem(rows int, columns int, mines int) string {
	for y := 0; y < rows; y++ {
		for x := 0; x < columns; x++ {
			var cells Minefield
			cells[y] = (1 << uint8(x))

			_cache := make(Cache)

			solution := tryToClick(_cache, Pos{x, y}, cells, rows, columns, rows*columns-mines-1)

			if solution != Impossible {
				var buf bytes.Buffer

				for k := 0; k < rows; k++ {
					for m := 0; m < columns; m++ {
						if solution[k]&(1<<uint8(m)) != 0 {
							if k == y && m == x {
								buf.WriteRune('c')
							} else {
								buf.WriteRune('.')
							}
						} else {
							buf.WriteRune('*')
						}
					}
					buf.WriteRune('\n')
				}

				return buf.String()
			}
		}
	}

	return "Impossible\n"
}

func main() {
	r := bufio.NewReader(os.Stdin)

	numCasesRaw, _ := r.ReadString('\n')

	numCases := 0
	fmt.Sscanf(numCasesRaw, "%d", &numCases)

	for i := 0; i < numCases; i++ {
		rows := 0
		columns := 0
		mines := 0

		testCase, _ := r.ReadString('\n')

		fmt.Sscanf(testCase, "%d %d %d", &rows, &columns, &mines)

		fmt.Printf("Case #%d:\n%s", i+1, solveProblem(rows, columns, mines))
	}
}
