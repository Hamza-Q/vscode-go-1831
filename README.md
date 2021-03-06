# Simple reproduction for [golang/vscode-go#1831](https://github.com/golang/vscode-go/issues/1831)

Summary for vscode-go: package name must come before `-testify.m` when invoking `go test`

Generally, all flags unknown to `test` must come after the package list.

See test.sh(test.sh) for explanation of results; here's an edited sample of execution output highlighting important bits:

```
# go test usage says:
#       usage: go test [build/test flags] [packages] [build/test flags & test binary flags]
#
# Notably, "test binary flags" (for example, '-testify.m') must be specified
# AFTER "packages"

# PKG before the unknown testify flag is correct and results in ldflags parsed
# correctly, irrespective of the ordering.
# (All commands run with "packages" specified before the testify flag succeed,
# output omitted from README for brevity)

# The package list after an unknown flag is incorrect - go test will assume it's an argument
# for the test executable, and pass all remaining arguments to the test executable.
# The test will run assuming "." as the test package.
+ go test -v -run '^TestSuite$' -testify.m '^TestLDFLAGS$' github.com/Hamza-Q/vscode-go-1831 -ldflags -X=github.com/Hamza-Q/vscode-go-1831.version=12345
=== RUN   TestSuite
    main_test.go:19: os.Args:
    main_test.go:20: [/tmp/go-build4189246570/b001/vscode-go-1831.test -test.paniconexit0 -test.timeout=10m0s -test.v=true -test.run=^TestSuite$ -testify.m ^TestLDFLAGS$ github.com/Hamza-Q/vscode-go-1831 -ldflags -X=github.com/Hamza-Q/vscode-go-1831.version=12345]
    main_test.go:21: flag.Args():
    main_test.go:22: [github.com/Hamza-Q/vscode-go-1831 -ldflags -X=github.com/Hamza-Q/vscode-go-1831.version=12345]
=== RUN   TestSuite/TestLDFLAGS
    main_test.go:30:
                Error Trace:    main_test.go:30
                Error:          Should NOT be empty, but was
                Test:           TestSuite/TestLDFLAGS
                Messages:       expected 'version' to be set by ldflags but it was empty!
--- FAIL: TestSuite (0.00s)
    --- FAIL: TestSuite/TestLDFLAGS (0.00s)
FAIL
exit status 1
FAIL    github.com/Hamza-Q/vscode-go-1831       0.004s

# Although "-ldflags" is picked up correctly for the below invocation, the PKG
# is still passed as an argument rather than interpreted by go test.
# "-ldflags" working in this scenario probably isn't something to rely on.
+ go test -v -run '^TestSuite$' -testify.m '^TestLDFLAGS$' -ldflags -X=github.com/Hamza-Q/vscode-go-1831.version=12345 github.com/Hamza-Q/vscode-go-1831
=== RUN   TestSuite
    main_test.go:19: os.Args:
    main_test.go:20: [/tmp/go-build3950920846/b001/vscode-go-1831.test -test.paniconexit0 -test.timeout=10m0s -test.v=true -test.run=^TestSuite$ -testify.m ^TestLDFLAGS$ github.com/Hamza-Q/vscode-go-1831]
    main_test.go:21: flag.Args():
    main_test.go:22: [github.com/Hamza-Q/vscode-go-1831]
=== RUN   TestSuite/TestLDFLAGS
--- PASS: TestSuite (0.00s)
    --- PASS: TestSuite/TestLDFLAGS (0.00s)
PASS
ok      github.com/Hamza-Q/vscode-go-1831       0.004s
```
