// RUN: %{swiftc} %s -o %T/ContinueAfterFailureTestCase
// RUN: %T/ContinueAfterFailureTestCase > %t || true
// RUN: %{xctest_checker} %t %s

#if os(macOS)
    import SwiftXCTest
#else
    import XCTest
#endif

// CHECK: Test Suite 'All tests' started at \d+-\d+-\d+ \d+:\d+:\d+\.\d+
// CHECK: Test Suite '.*\.xctest' started at \d+-\d+-\d+ \d+:\d+:\d+\.\d+

// CHECK: Test Suite 'ContinueAfterFailureTestCase' started at \d+-\d+-\d+ \d+:\d+:\d+\.\d+
class ContinueAfterFailureTestCase: XCTestCase {
    static var allTests = {
        return [
            ("test_fails", test_fails)
        ]
    }()
    
    // CHECK: Test Case 'ContinueAfterFailureTestCase.test_fails' started at \d+-\d+-\d+ \d+:\d+:\d+\.\d+
    // CHECK: .*/ContinueAfterFailureTestCase/main.swift:[[@LINE+3]]: error: ContinueAfterFailureTestCase.test_fails : XCTAssertTrue failed -
    // CHECK: Test Case 'ContinueAfterFailureTestCase.test_fails' failed \(\d+\.\d+ seconds\)
    func test_fails() {
        XCTAssert(false)
    }
}
// CHECK: Test Suite 'ContinueAfterFailureTestCase' failed at \d+-\d+-\d+ \d+:\d+:\d+\.\d+
// CHECK: \t Executed 1 test, with 1 failure \(0 unexpected\) in \d+\.\d+ \(\d+\.\d+\) seconds

XCTMain([testCase(ContinueAfterFailureTestCase.allTests)])

// CHECK: Test Suite '.*\.xctest' failed at \d+-\d+-\d+ \d+:\d+:\d+\.\d+
// CHECK: \t Executed 1 test, with 1 failure \(0 unexpected\) in \d+\.\d+ \(\d+\.\d+\) seconds
// CHECK: Test Suite 'All tests' failed at \d+-\d+-\d+ \d+:\d+:\d+\.\d+
// CHECK: \t Executed 1 test, with 1 failure \(0 unexpected\) in \d+\.\d+ \(\d+\.\d+\) seconds
