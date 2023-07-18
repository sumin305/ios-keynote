import Foundation

final class SquareSlide: SquareSlidable {
    var id: String
    var rgb: RGBColor
    var alpha: AlphaType
    var side: Int

    init(id: String, rgb: RGBColor, alpha: AlphaType, side: Int) {
        self.id = id
        self.rgb = rgb
        self.alpha = alpha
        self.side = side
    }
}

extension SquareSlide: CustomStringConvertible {
    var description: String {
        return "\(id.subString(from: 0, to: 2))-\(id.subString(from: 3, to: 5))-\(id.subString(from: 6, to: 8)), Side:\(side), R:\(rgb.red), G:\(rgb.green), B:\(rgb.blue), Alpha: \(String(alpha.rawValue))"
    }
}
