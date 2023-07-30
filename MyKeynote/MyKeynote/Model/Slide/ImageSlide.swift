import Foundation

final class ImageSlide: Slidable {
    
    typealias Content = ImageContent
    
    private(set) var id: String
    private(set) var content: Content

    init(id: String, content: Content) {
        self.id = id
        self.content = content
    }
    
    func changeAlpha(alpha: AlphaType) {
        self.content.changeAlpha(alpha: alpha)
    }
}

