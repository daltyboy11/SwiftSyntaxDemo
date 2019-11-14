import SwiftSyntax

final class SnakeCaseRewriter: SyntaxRewriter {

  // We'll consider an identifier snake case if it has two or more
  // non-underscore groups of characters separated by underscores
  private func isSnakeCase(_ identifier: String) -> Bool {
    return identifier
      .components(separatedBy: "_")
      .filter({!$0.isEmpty})
      .count > 1
  }

  /// Removes all underscores from the identifier and capitalizes characters
  /// following underscores. Assumes `identifier` is a valid identifier.
  private func convertToCamelCase(_ identifier: String) -> String {
    let identifier = Array(identifier)
    var newIdentifier = ""
    var i = 0
    while i < identifier.count {
      if identifier[i] == "_" && i+1 < identifier.count &&
      ("a"..."z").contains(identifier[i+1]) {
        newIdentifier.append(identifier[i+1].uppercased())
        i += 2
      } else if identifier[i] != "_" {
        newIdentifier.append(identifier[i])
        i += 1
      } else {
        i += 1
      }
    }
    return newIdentifier
  }

  override func visit(_ node: IdentifierPatternSyntax) -> PatternSyntax {
    guard case .identifier(let identifier) = node.identifier.tokenKind else { return node }
    if isSnakeCase(identifier) {
      let newIdentifier = convertToCamelCase(identifier)
      let newToken = node.identifier.withKind(.identifier(newIdentifier))
      let newNode = node.withIdentifier(newToken)
      return super.visit(newNode)
    }

    return super.visit(node)
  }

  override func visit(_ node: IdentifierExprSyntax) -> ExprSyntax {
    guard case .identifier(let identifier) = node.identifier.tokenKind else { return node }
    if isSnakeCase(identifier) {
      let newIdentifier = convertToCamelCase(identifier)
      let newToken = node.identifier.withKind(.identifier(newIdentifier))
      let newNode = node.withIdentifier(newToken)
      return super.visit(newNode)
    }
    return super.visit(node)
  }
}
