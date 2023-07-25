import Foundation

protocol Contentable {
    var type: ContentType { get }
    var alpha: AlphaType { get }
    func changeAlpha(alpha: AlphaType)
}
