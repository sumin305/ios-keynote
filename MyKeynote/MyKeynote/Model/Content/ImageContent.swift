import Foundation

final class ImageContent: Contentable {
    private(set) var alpha: AlphaType
    private var (height, width): (CGFloat, CGFloat)
    let type: ContentType = .image

    init(alpha: AlphaType, height: CGFloat, width: CGFloat) {
        self.alpha = alpha
        self.height = height
        self.width = width
    }
    func changeAlpha(alpha: AlphaType) {
        self.alpha = alpha
    }
}
 
