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
            ("testContinueAfterFailure", testContinueAfterFailure),
            ("testDoesNotContinueAfterFailure", testDoesNotContinueAfterFailure)
        ]
    }()
    
    // CHECK: Test Case 'ContinueAfterFailureTestCase.testContinueAfterFailure' started at \d+-\d+-\d+ \d+:\d+:\d+\.\d+
    // CHECK: First assertion
    // CHECK: .*/ContinueAfterFailureTestCase/main.swift:[[@LINE+6]]: error: ContinueAfterFailureTestCase.testContinueAfterFailure : XCTAssertTrue failed -
    // CHECK: Second assertion
    // CHECK: Test Case 'ContinueAfterFailureTestCase.testContinueAfterFailure' failed \(\d+\.\d+ seconds\)
    func testContinueAfterFailure() {
        continueAfterFailure = true
        print("First assertion")
        XCTAssert(false)
        print("Second assertion")
    }
    
    // CHECK: Test Case 'ContinueAfterFailureTestCase.testDoesNotContinueAfterFailure' started at \d+-\d+-\d+ \d+:\d+:\d+\.\d+
    // CHECK: First assertion
    // CHECK: .*/ContinueAfterFailureTestCase/main.swift:[[@LINE+4]]: error: ContinueAfterFailureTestCase.testDoesNotContinueAfterFailure : XCTAssertTrue failed -
    func testDoesNotContinueAfterFailure() {
        continueAfterFailure = false
        print("First assertion")
        XCTAssert(false)
        print("Second assertion")
    }
}

XCTMain([testCase(ContinueAfterFailureTestCase.allTests)])
