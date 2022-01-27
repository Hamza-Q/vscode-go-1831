package main

import (
	"flag"
	"os"
	"testing"

	"github.com/stretchr/testify/suite"
)

var version string

func TestSuite(t *testing.T) {
	printArgs(t)
	suite.Run(t, new(exampleSuite))
}

func printArgs(t *testing.T) {
	t.Log("os.Args:")
	t.Log(os.Args)
	t.Log("flag.Args():")
	t.Log(flag.Args())
}

type exampleSuite struct {
	suite.Suite
}

func (s *exampleSuite) TestLDFLAGS() {
	s.Require().NotEmpty(version, "expected 'version' to be set by ldflags but it was empty!")
}
