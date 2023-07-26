import Foundation

protocol Contentable {
    var alpha: AlphaType { get }
    func changeAlpha(alpha: AlphaType)
}
