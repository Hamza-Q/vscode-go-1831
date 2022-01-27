#!/bin/bash
set -x

PKG=github.com/Hamza-Q/vscode-go-1831

# invoke go test with the following flags in various orderings:
RUN='-run ^TestSuite$'
LDFLAGS="-ldflags -X=$PKG.version=12345"
TESTIFY='-testify.m ^TestLDFLAGS$'

# go test usage is:
# 	usage: go test [build/test flags] [packages] [build/test flags & test binary flags]
#
# Notably, "test binary flags" (for example, '-testify.m') must be specified
# AFTER "packages"

# PKG before the unknown testify flag is correct and results in ldflags parsed
# correctly, irrespective of the ordering.
go test $RUN $PKG $LDFLAGS $TESTIFY
go test $RUN $PKG $TESTIFY $LDFLAGS

go test $PKG $RUN $LDFLAGS $TESTIFY
go test $PKG $RUN $TESTIFY $LDFLAGS

go test $PKG $LDFLAGS $RUN $TESTIFY
go test $PKG $LDFLAGS $TESTIFY $RUN

go test $PKG $TESTIFY $RUN $LDFLAGS
go test $PKG $TESTIFY $LDFLAGS $RUN

# PKG after an unknown flag is incorrect - go test will assume it's an argument
# for the test executable, and treat all remaining arguments as belonging to
# the test executable.
# The test will run assuming "." as the test package.
go test -v -run '^TestSuite$' $TESTIFY $PKG $LDFLAGS

# Although "-ldflags" is picked up correctly for the below invocation, the PKG
# is still passed as an argument rather than interpreted by go test.
# "-ldflags" working in this scenario probably isn't something to rely on.
go test -v -run '^TestSuite$' $TESTIFY $LDFLAGS $PKG 
