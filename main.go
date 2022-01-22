package main

import "fmt"

var version string

func init() {
	if version == "" {
		panic("version not initialized by ldflags")
	}
}

func main() {
	fmt.Println("Hello, world!")
}
