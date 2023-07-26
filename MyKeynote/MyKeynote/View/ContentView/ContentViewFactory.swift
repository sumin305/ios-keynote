import UIKit
// 뷰는 그리기만 해야되는데 왜 지가 판단?
class ContentViewFactory {
    func createSquareContentView(content: Contentable) -> SquareContentView {
        return SquareContentView(content: content)
    }
    func createImageContentView(content: Contentable) -> ImageContentView {
        return ImageContentView(content: content)

    }
}
