import SwiftSyntax

final class IntegerLiteralFormatter: SyntaxRewriter {
  override func visit(_ token: TokenSyntax) -> Syntax {
    // Only transform integer literals.
    guard case .integerLiteral(let text) = token.tokenKind else {
      return super.visit(token)
    }

    // Remove existing underscores
    let integerTextWithoutUnderscores = String(text.filter {
                                                 ("0"..."9").contains($0) })

    // Starting from the least significant digit, we will add an underscore
    // every three digits
    var integerTextWithUnderscores = "" 
    for (i, c) in integerTextWithoutUnderscores.reversed().enumerated() {
      if i % 3 == 0 && i != 0 { // don't add an underscore to the beginning!
        integerTextWithUnderscores.append("_")
      }
      integerTextWithUnderscores.append(c)
    }
    integerTextWithUnderscores = String(integerTextWithUnderscores.reversed())

    // Return the same integer literal token, but with the underscores
    let newToken = token.withKind(.integerLiteral(integerTextWithUnderscores))
    return super.visit(newToken)
  }
}
