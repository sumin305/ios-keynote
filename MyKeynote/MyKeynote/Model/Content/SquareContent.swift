import Foundation

final class SquareContent: Contentable {
    private(set) var alpha: AlphaType
    private(set) var rgbColor: RGBColor
    private(set) var side: Int
    let type: ContentType = .square // SK 확장 유리
    
    init(alpha: AlphaType, rgbColor: RGBColor, side: Int) {
        self.alpha = alpha
        self.rgbColor = rgbColor
        self.side = side
    }
    
    func changeRGBColor(color: RGBColor) {
        self.rgbColor = color
    }
    
    func changeAlpha(alpha: AlphaType)  {
        self.alpha = alpha
    }
    
    func changeSide(side: Int) {
        self.side = side
    }
}
