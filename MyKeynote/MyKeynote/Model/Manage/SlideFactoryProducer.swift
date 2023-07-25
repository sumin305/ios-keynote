import Foundation

final class SlideFactoryProducer {
    static func getFactory(contentType: ContentType) -> SlideFactory {
        if contentType == .square {
            return SquareSlideFactory()
        } else {
            return ImageSlideFactory()
        }
    }
}
