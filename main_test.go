package main

import (
	"testing"

	"github.com/stretchr/testify/suite"
)

func TestSuite(t *testing.T) {
	s := new(dummySuite)
	suite.Run(t, s)
}

type dummySuite struct {
	suite.Suite
}

func (dummySuite) TestNothing() {
}
