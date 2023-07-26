import Foundation

final class SlideManager {
    
    private var slideArray: [any Slidable] = []
    private var currentSlideIndex: Int = 0
    
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
    
    func changeRGBColor(color: RGBColor) {
        (slideArray[currentSlideIndex].content as? SquareContent)?.changeRGBColor(color: color)
    }
    
    func changeAlpha(alpha: AlphaType) {
        slideArray[currentSlideIndex].content?.changeAlpha(alpha: alpha)
    }
    
    func getContentAlpha() -> AlphaType {
        return (slideArray[currentSlideIndex].content?.alpha) ?? .one
    }
    
    func getContent() -> Contentable {
        return (slideArray[currentSlideIndex].content)!
    }
    
    func getSlides() -> [any Slidable] {
        return slideArray
    }
    func getSlideIndex() -> Int {
        return currentSlideIndex
    }
    
    subscript(index: Int) -> (any Slidable)? {
        guard index < slideArray.count else { return nil }
        return slideArray[index]
    }
}

