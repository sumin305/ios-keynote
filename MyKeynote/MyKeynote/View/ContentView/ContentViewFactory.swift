import UIKit
enum ContentViewFactory {
    static func createSquareContentView(content: Contentable) -> SquareContentView {
        return SquareContentView(content: content)
    }
    static func createImageContentView(content: Contentable) -> ImageContentView {
        return ImageContentView(content: content)
    }
}
