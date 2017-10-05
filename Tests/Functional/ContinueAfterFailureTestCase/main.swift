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
            ("testContinueAfterFailure", testContinueAfterFailure)
        ]
    }()
    
    // CHECK: Test Case 'ContinueAfterFailureTestCase.testContinueAfterFailure' started at \d+-\d+-\d+ \d+:\d+:\d+\.\d+
    // CHECK: First assertion
    // CHECK: .*/ContinueAfterFailureTestCase/main.swift:[[@LINE+5]]: error: ContinueAfterFailureTestCase.testContinueAfterFailure : XCTAssertTrue failed -
    // CHECK: Second assertion
    // CHECK: Test Case 'ContinueAfterFailureTestCase.testContinueAfterFailure' failed \(\d+\.\d+ seconds\)
    func testContinueAfterFailure() {
        print("First assertion")
        XCTAssert(false)
        print("Second assertion")
    }
}
// CHECK: Test Suite 'ContinueAfterFailureTestCase' failed at \d+-\d+-\d+ \d+:\d+:\d+\.\d+
// CHECK: \t Executed 1 test, with 1 failure \(0 unexpected\) in \d+\.\d+ \(\d+\.\d+\) seconds

XCTMain([testCase(ContinueAfterFailureTestCase.allTests)])

// CHECK: Test Suite '.*\.xctest' failed at \d+-\d+-\d+ \d+:\d+:\d+\.\d+
// CHECK: \t Executed 1 test, with 1 failure \(0 unexpected\) in \d+\.\d+ \(\d+\.\d+\) seconds
// CHECK: Test Suite 'All tests' failed at \d+-\d+-\d+ \d+:\d+:\d+\.\d+
// CHECK: \t Executed 1 test, with 1 failure \(0 unexpected\) in \d+\.\d+ \(\d+\.\d+\) seconds
