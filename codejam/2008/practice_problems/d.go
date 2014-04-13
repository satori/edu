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
	"math"
	"os"
	"strings"
)

const (
	EmptyItemsMask uint32 = 0xffff
)

type Pos struct {
	x int
	y int
}

type Store struct {
	pos    Pos
	items  uint16
	prices [16]float64
}

var Home = Pos{0, 0}

func zeroBit(b uint32, idx uint8) uint32 {
	return b & ((1 << idx) ^ 0xffffffff)
}

func isPerishable(items uint32, idx uint8) bool {
	return (items & (1 << (idx+16))) != 0
}

func gasCost(pos Pos, dest Pos, price float64) float64 {
	diff_x := dest.x - pos.x
	diff_y := dest.y - pos.y
	return math.Sqrt(float64(diff_x*diff_x+diff_y*diff_y)) * price
}

func getCacheId(pos Pos, items uint16, perishing bool) uint64 {
	var cacheId uint64 = 0
	cacheId |= uint64(uint16(pos.x)) << 48
	cacheId |= uint64(uint16(pos.y)) << 32
	cacheId |= uint64(items) << 16
	if perishing {
		cacheId |= 1
	}
	return cacheId
}

type Cache map[uint64]float64

func findMinCost(_cache Cache, pos Pos, items uint32, priceOfGas float64, stores []Store, perishing bool) float64 {
	_cacheId := getCacheId(pos, uint16(items), perishing)

	if min_cost, ok := _cache[_cacheId]; ok {
		return min_cost
	}

	if items & EmptyItemsMask == 0 && perishing == false {
		return gasCost(pos, Home, priceOfGas)
	}

	min_cost := math.Inf(1)

	var item uint8

	for item = 0; item < 16; item++ {
		if items&(1<<item) == 0 {
			continue
		}

		remaining := zeroBit(items, item)

		for _, store := range stores {
			if (store.items&(1<<item)) == 0 || (perishing && (pos.x != store.pos.x || pos.y != store.pos.y)) {
				continue
			}

			cost := gasCost(pos, store.pos, priceOfGas) + store.prices[item]

			if isPerishable(items, item) || perishing {
				costOne := gasCost(store.pos, Home, priceOfGas) + findMinCost(_cache, Home, remaining, priceOfGas, stores, false)
				costTwo := findMinCost(_cache, store.pos, remaining, priceOfGas, stores, true)

				cost = cost + math.Min(costOne, costTwo)
			} else {
				cost = cost + findMinCost(_cache, store.pos, remaining, priceOfGas, stores, false)
			}

			min_cost = math.Min(min_cost, cost)
		}
	}

	_cache[_cacheId] = min_cost
	return min_cost
}

func solveProblem(items uint32, priceOfGas float64, stores []Store) float64 {
	_cache := make(Cache)
	return findMinCost(_cache, Home, items, priceOfGas, stores, false)
}

func main() {
	r := bufio.NewReader(os.Stdin)

	numCasesRaw, _ := r.ReadString('\n')

	numCases := 0
	fmt.Sscanf(numCasesRaw, "%d", &numCases)

	for i := 0; i < numCases; i++ {
		numItems := 0
		numStores := 0
		priceOfGas := 0.0

		testCase, _ := r.ReadString('\n')
		fmt.Sscanf(testCase, "%d %d %f", &numItems, &numStores, &priceOfGas)

		var items uint32 = 0

		itemIds := make(map[string]uint8)

		itemsRaw, _ := r.ReadString('\n')
		itemNames := strings.Split(strings.TrimRight(itemsRaw, "\n"), " ")

		for k, itemName := range itemNames {
			items |= (1 << uint8(k))
			itemIds[strings.TrimRight(itemName, "!")] = uint8(k)
			if strings.HasSuffix(itemName, "!") {
				items |= (1 << uint8(k+16))
			}
		}

		stores := make([]Store, 0)
		for j := 0; j < numStores; j++ {
			storeRaw, _ := r.ReadString('\n')
			storeParams := strings.Split(strings.TrimRight(storeRaw, "\n"), " ")

			store := Store{}
			fmt.Sscanf(storeParams[0], "%d", &store.pos.x)
			fmt.Sscanf(storeParams[1], "%d", &store.pos.y)

			for _, item := range storeParams[2:] {
				itemParams := strings.Split(item, ":")
				itemName := itemParams[0]
				itemPrice := 0.0
				fmt.Sscanf(itemParams[1], "%f", &itemPrice)
				itemId := itemIds[itemName]
				store.items |= (1 << itemId)
				store.prices[itemId] = itemPrice
			}

			stores = append(stores, store)
		}

		fmt.Printf("Case #%d: %9.7f\n", i+1, solveProblem(items, priceOfGas, stores))
	}
}
