package main

import "fmt"

// Go already has a built-in map type so we'll build a lookup function
// around that. The interface for this lookup function (which features
// Go's ability to return multiple values) feels simpler to me than
// C's version because you don't have to mess with pointers. But this
// function has the same exact contract with its callers as C because
// before using the returned "value" the caller MUST check that the
// key actually exists. Failing to do so could introduce some sort of
// bug.
func lookup(key string, m map[string]int) (int, bool) {
	value, exists := m[key]
	return value, exists
}

func printValueIfKeyExists(key string, m map[string]int) {
	value, exists := lookup(key, m)
	if exists {
		fmt.Printf("at key %q the value is: %d\n", key, value)
	} else {
		fmt.Printf("there is no value for key %q\n", key)
	}
}

func main() {
	mapping := map[string]int{
		"hello-world":             1,
		"meaning-of-life":         42,
		"number-of-lotr-rings":    20,
		"num-wheel-of-time-books": 14,
	}
	printValueIfKeyExists("hello-world", mapping)
	printValueIfKeyExists("does-not-exist", mapping)
	printValueIfKeyExists("meaning-of-life", mapping)
	// // We see here (again) that the code still compiles and runs
	// // even though we've used the "lookup" function incorrectly
	// // (we didn't check the returned boolean which says if the key
	// // exists).
	// key := "does-not-exist"
	// value, _ := lookup(key, mapping)
	// fmt.Printf("at key %q the value is: %d\n", key, value)
}
