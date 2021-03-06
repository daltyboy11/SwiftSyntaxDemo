import XCTest
import SwiftSyntax

@testable import SwiftSyntaxDemo

final class SwiftSyntaxDemoTests: XCTestCase {
  private let testDirectoryPrefix = "./Tests/SwiftSyntaxDemoTests/"

  func testIntegerLiteralFormatter() {
    let url = URL(fileURLWithPath: testDirectoryPrefix + "input1.txt")
    let sourceFile = try! SyntaxTreeParser.parse(url)
    let reformattedSource = IntegerLiteralRewriter().visit(sourceFile)
    XCTAssertEqual(
      String(describing: reformattedSource),
      try! String(contentsOfFile: testDirectoryPrefix + "expected1.txt", encoding: .utf8))
  }

  func testSnakeCaseRewriter1() {
    let url = URL(fileURLWithPath: testDirectoryPrefix + "input2.txt")
    let sourceFile = try! SyntaxTreeParser.parse(url)
    let reformattedSource = SnakeCaseRewriter().visit(sourceFile)
    XCTAssertEqual(
      String(describing: reformattedSource),
      try! String(contentsOfFile: testDirectoryPrefix + "expected2.txt", encoding: .utf8))
  }

  func testSnakeCaseRewriter2() {
    let url = URL(fileURLWithPath: testDirectoryPrefix + "input3.txt")
    let sourceFile = try! SyntaxTreeParser.parse(url)
    let reformattedSource = SnakeCaseRewriter().visit(sourceFile)
    XCTAssertEqual(
      String(describing: reformattedSource),
      try! String(contentsOfFile: testDirectoryPrefix + "expected3.txt", encoding: .utf8))
  }

  func testSnakeCaseRewriter3() {
    let url = URL(fileURLWithPath: testDirectoryPrefix + "input4.txt")
    let sourceFile = try! SyntaxTreeParser.parse(url)
    let reformattedSource = SnakeCaseRewriter().visit(sourceFile)
    XCTAssertEqual(
      String(describing: reformattedSource),
      try! String(contentsOfFile: testDirectoryPrefix + "expected4.txt", encoding: .utf8))
  }
}
