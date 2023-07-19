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
