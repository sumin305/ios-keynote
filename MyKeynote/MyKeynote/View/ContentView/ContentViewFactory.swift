import UIKit
// 뷰는 그리기만 해야되는데 왜 지가 판단?
class ContentViewFactory {
    func createContentView(content: Contentable) -> ContentView {
        if content.type == .square {
            return SquareContentView(content: content)
        } else {
            return ImageContentView(content: content)
        }
    }
}
