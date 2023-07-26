import Foundation

final class SlideFactoryProducer {
    static func getFactory(contentType: ContentType) -> SlideFactory {
        switch contentType {
            case .square: return SquareSlideFactory()
            default: return ImageSlideFactory()
        }
    }
}
