import Foundation

// view에서는 alpha값은 0.0~1.0이고 1.0으로 갈수록 불투명
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

extension AlphaType {
    var alphaValue: CGFloat {
        return CGFloat(Double(11 - (self.rawValue)) * 0.1)
    }
}
