import Foundation

final class SquareSlide: Slidable, CustomStringConvertible {
    
    typealias Content = SquareContent
    
    private(set) var id: String
    private(set) var content: Content?

    init(id: String) {
        self.id = id
    }
    
    convenience init(id: String, content: Content) {
        self.init(id: id)
        self.content = content
    }

    func changeAlpha(alpha: AlphaType) {
        self.content?.changeAlpha(alpha: alpha)
    }
}

