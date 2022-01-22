package main

import (
	"testing"

	"github.com/stretchr/testify/suite"
)

var version string

func TestSuite(t *testing.T) {
	suite.Run(t, new(exampleSuite))
}

type exampleSuite struct {
	suite.Suite
}

func (s *exampleSuite) TestLDFLAGS() {
	s.Require().NotEmpty(version, "expected 'version' to be set by ldflags but it was empty!")
}
