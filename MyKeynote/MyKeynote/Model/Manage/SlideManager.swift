import Foundation

final class SlideManager {
    
    var slideArray: [any Slidable] = []
    var currentSlideIndex: Int = 0
    
    func produceRandomSlide(contentType: ContentType) -> any Slidable {
        let slideFactory = SlideFactoryProducer.getFactory(contentType: contentType)
        return slideFactory.getRandomSlide()
    }
    
    func getFourSquareSlide() {
        let squareSlideFactory = SlideFactoryProducer.getFactory(contentType: .square)
        (squareSlideFactory as? SquareSlideFactory)?.getFourSquareSlide()
    }
    
    func addRandomSlide() {
        let slide = produceRandomSlide(contentType: .square) // 테스트를 위해 정사각 슬라이드 생성
//        let slide = produceRandomSlide(contentType: ContentType.allCases.randomElement() ?? .square)
        slideArray.append(slide)
    }
    
    func getSlideCount() -> Int {
        return slideArray.count
    }
    
    subscript(index: Int) -> (any Slidable)? {
        guard index < slideArray.count else { return nil }
        return slideArray[index]
    }
}

