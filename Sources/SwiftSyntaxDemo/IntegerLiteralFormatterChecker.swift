import SwiftSyntax

final class IntegerLiteralFormatterChecker: SyntaxRewriter {
  private var integerLiteralsAreProperlyFormattedWithUnderscores = true

  func hasNonUnderscoreSeparatedIntegerLiterals(_ node: Syntax) -> Bool {
    integerLiteralsAreProperlyFormattedWithUnderscores = true
    _ = visit(node)
    return !integerLiteralsAreProperlyFormattedWithUnderscores 
  }

  override func visit(_ token: TokenSyntax) -> Syntax {
    // Only transform integer literals.
    guard case .integerLiteral(let text) = token.tokenKind else {
      return super.visit(token)
    }

    // If an integer literal has less than 3 or fewer characters but contains
    // an underscore it is improperly formatted because we only want to separate
    // groups of three digits!.
    // Otherwise check that every fourth character (starting from the least
    // significant digit) is an underscore and no other characters are
    // underscores (we don't want consecutive underscores or underscores in the
    // wrong place)!
    if text.count <= 3 && text.contains("_") {
      integerLiteralsAreProperlyFormattedWithUnderscores = false
    }

    for (i, c) in text.reversed().enumerated() {
      if (i+1) % 4 == 0 && c != "_" ||
        (i+1) % 4 != 0 && c == "_" {
        integerLiteralsAreProperlyFormattedWithUnderscores = false
        break
      }
    }

    return super.visit(token)
  }
}
