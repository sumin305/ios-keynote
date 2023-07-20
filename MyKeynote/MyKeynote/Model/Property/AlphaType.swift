import Foundation

// view에서는 alpha값은 0.0~1.0이고 1.0으로 갈수록 불투명
enum AlphaType: Int, CaseIterable {
    case one = 1 // 1.0
    case two // 0.9
    case three // 0.8
    case four // 0.7
    case five // 0.6
    case six // 0.5
    case seven // 0.4
    case eight // 0.3
    case nine // 0.2
    case ten // 0.1
    
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
