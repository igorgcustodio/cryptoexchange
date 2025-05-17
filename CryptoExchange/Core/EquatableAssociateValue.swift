import Foundation

/// Protocol to compare enums with associate values.
public protocol EquatableAssociateValue: Equatable {}

extension EquatableAssociateValue {
    public var rawValue: String {
        let text = String(describing: self)
        return text.split(separator: "(").first.map { String($0) } ?? text
    }

    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.rawValue == rhs.rawValue
    }
}
