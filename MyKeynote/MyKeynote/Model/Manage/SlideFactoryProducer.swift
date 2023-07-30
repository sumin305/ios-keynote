import Foundation
// 팩팩 필요할까 공부해보고 고치기
final class SlideFactoryProducer {
    static func getFactory(contentType: ContentType) -> SlideFactory {
        switch contentType {
            case .square: return SquareSlideFactory()
            default: return ImageSlideFactory()
        }
    }
}
