# Simple reproduction for [golang/vscode-go#1831](https://github.com/golang/vscode-go/issues/1831)

Summary for vscode-go: package name must come before `-testify.m` when invoking `go test`

Generally, all flags unknown to `test` must come after the package list.

See test.sh(test.sh) for explanation of results; expected output is:

```console
+ PKG=github.com/Hamza-Q/vscode-go-1831
+ RUN='-run ^TestSuite$'
+ LDFLAGS='-ldflags -X=github.com/Hamza-Q/vscode-go-1831.version=12345'
+ TESTIFY='-testify.m ^TestLDFLAGS$'
+ go test -run '^TestSuite$' github.com/Hamza-Q/vscode-go-1831 -ldflags -X=github.com/Hamza-Q/vscode-go-1831.version=12345 -testify.m '^TestLDFLAGS$'
ok      github.com/Hamza-Q/vscode-go-1831       0.003s
+ go test -run '^TestSuite$' github.com/Hamza-Q/vscode-go-1831 -testify.m '^TestLDFLAGS$' -ldflags -X=github.com/Hamza-Q/vscode-go-1831.version=12345
ok      github.com/Hamza-Q/vscode-go-1831       0.003s
+ go test github.com/Hamza-Q/vscode-go-1831 -run '^TestSuite$' -ldflags -X=github.com/Hamza-Q/vscode-go-1831.version=12345 -testify.m '^TestLDFLAGS$'
ok      github.com/Hamza-Q/vscode-go-1831       0.003s
+ go test github.com/Hamza-Q/vscode-go-1831 -run '^TestSuite$' -testify.m '^TestLDFLAGS$' -ldflags -X=github.com/Hamza-Q/vscode-go-1831.version=12345
ok      github.com/Hamza-Q/vscode-go-1831       0.004s
+ go test github.com/Hamza-Q/vscode-go-1831 -ldflags -X=github.com/Hamza-Q/vscode-go-1831.version=12345 -run '^TestSuite$' -testify.m '^TestLDFLAGS$'
ok      github.com/Hamza-Q/vscode-go-1831       0.003s
+ go test github.com/Hamza-Q/vscode-go-1831 -ldflags -X=github.com/Hamza-Q/vscode-go-1831.version=12345 -testify.m '^TestLDFLAGS$' -run '^TestSuite$'
ok      github.com/Hamza-Q/vscode-go-1831       0.004s
+ go test github.com/Hamza-Q/vscode-go-1831 -testify.m '^TestLDFLAGS$' -run '^TestSuite$' -ldflags -X=github.com/Hamza-Q/vscode-go-1831.version=12345
ok      github.com/Hamza-Q/vscode-go-1831       0.004s
+ go test github.com/Hamza-Q/vscode-go-1831 -testify.m '^TestLDFLAGS$' -ldflags -X=github.com/Hamza-Q/vscode-go-1831.version=12345 -run '^TestSuite$'
ok      github.com/Hamza-Q/vscode-go-1831       0.004s
+ go test -v -run '^TestSuite$' -testify.m '^TestLDFLAGS$' github.com/Hamza-Q/vscode-go-1831 -ldflags -X=github.com/Hamza-Q/vscode-go-1831.version=12345
=== RUN   TestSuite
    main_test.go:19: os.Args:
    main_test.go:20: [/tmp/go-build1238722046/b001/vscode-go-1831.test -test.paniconexit0 -test.timeout=10m0s -test.v=true -test.run=^TestSuite$ -testify.m ^TestLDFLAGS$ github.com/Hamza-Q/vscode-go-1831 -ldflags -X=github.com/Hamza-Q/vscode-go-1831.version=12345]
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
+ go test -v -run '^TestSuite$' -testify.m '^TestLDFLAGS$' -ldflags -X=github.com/Hamza-Q/vscode-go-1831.version=12345 github.com/Hamza-Q/vscode-go-1831
=== RUN   TestSuite
    main_test.go:19: os.Args:
    main_test.go:20: [/tmp/go-build655204720/b001/vscode-go-1831.test -test.paniconexit0 -test.timeout=10m0s -test.v=true -test.run=^TestSuite$ -testify.m ^TestLDFLAGS$ github.com/Hamza-Q/vscode-go-1831]
    main_test.go:21: flag.Args():
    main_test.go:22: [github.com/Hamza-Q/vscode-go-1831]
=== RUN   TestSuite/TestLDFLAGS
--- PASS: TestSuite (0.00s)
    --- PASS: TestSuite/TestLDFLAGS (0.00s)
PASS
ok      github.com/Hamza-Q/vscode-go-1831       0.004s
```
