import Foundation

enum AlphaType: Int, CaseIterable {
    case one = 1
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case ten
    
    static func random() -> AlphaType {
        if let alpha = AlphaType.allCases.randomElement() {
            return alpha
        }
        return .one
    }
}

