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
	"fmt"
	"math/big"
	"math/rand"
	"os"
	"runtime"
	"strings"
	"sync"
	"sync/atomic"
)

const (
	limit      = 1000
	numTries   = 250000
	numThreads = 8
)

var (
	badStats  [limit * limit]int64
	goodStats [limit * limit]int64
)

func init() {
	runtime.GOMAXPROCS(runtime.NumCPU())

	var wg sync.WaitGroup

	for thread := 0; thread < numThreads; thread++ {
		wg.Add(1)

		rng := rand.New(rand.NewSource(int64(thread)))

		go func() {
			for i := 0; i < numTries; i++ {
				var badSeq [limit]int
				var goodSeq [limit]int

				for j := 0; j < limit; j++ {
					badSeq[j] = j
					goodSeq[j] = j
				}

				for j := 0; j < limit; j++ {
					p := rng.Intn(limit)
					badSeq[j], badSeq[p] = badSeq[p], badSeq[j]

					p = rng.Intn(limit-j) + j
					goodSeq[j], goodSeq[p] = goodSeq[p], goodSeq[j]
				}

				for j := 0; j < limit; j++ {
					atomic.AddInt64(&badStats[j*limit+badSeq[j]], 1)
					atomic.AddInt64(&goodStats[j*limit+goodSeq[j]], 1)
				}
			}

			wg.Done()
		}()
	}

	wg.Wait()
}

func solveProblem(seq [limit]int) string {
	bad := big.NewInt(1)
	good := big.NewInt(1)

	for i, v := range seq {
		badScore := big.NewInt(badStats[i*limit+v])
		goodScore := big.NewInt(goodStats[i*limit+v])

		bad.Mul(bad, badScore)
		good.Mul(good, goodScore)
	}

	if good.Cmp(bad) > 0 {
		return "GOOD"
	}

	return "BAD"
}

func main() {
	r := bufio.NewReader(os.Stdin)

	numCasesRaw, _ := r.ReadString('\n')

	numCases := 0
	fmt.Sscanf(numCasesRaw, "%d", &numCases)

	for i := 0; i < numCases; i++ {
		r.ReadString('\n')
		testCaseRaw, _ := r.ReadString('\n')
		testCaseItems := strings.Split(strings.TrimRight(testCaseRaw, "\n"), " ")

		var testCase [limit]int

		for j := 0; j < limit; j++ {
			fmt.Sscanf(testCaseItems[j], "%d", &testCase[j])
		}

		fmt.Printf("Case #%d: %s\n", i+1, solveProblem(testCase))
	}
}
