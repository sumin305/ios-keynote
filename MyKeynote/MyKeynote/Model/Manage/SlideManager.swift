import Foundation

final class SlideManager {
    
    private var slideArray: [any Slidable] = []
    private var currentSlideIndex: Int = 0
    
    func produceRandomSlide() -> any Slidable {
//        let slideFactory = SlideFactoryProducer.getFactory(contentType: ContentType.allCases.randomElement()!)
        let slideFactory = SlideFactoryProducer.getFactory(contentType: .square)
        return slideFactory.getRandomSlide()
    }
    
    func getFourSquareSlide() {
        let squareSlideFactory = SlideFactoryProducer.getFactory(contentType: .square)
        (squareSlideFactory as? SquareSlideFactory)?.getFourSquareSlide()
    }
    
    func addRandomSlide() {
        let slide = produceRandomSlide() // 테스트를 위해 정사각 슬라이드 생성
        slideArray.append(slide)
        NotificationCenter.default.post(name: Notification.Name.slideAdded, object: self,
                                        userInfo: ["slide":slideArray.last!])
    }
    
    func getSlideCount() -> Int {
        return slideArray.count
    }
    
    func changeRGBColor(color: RGBColor) {
        (slideArray[currentSlideIndex].content as? SquareContent)?.changeRGBColor(color: color)
        NotificationCenter.default.post(name: Notification.Name.colorChanged, object: slideArray[currentSlideIndex].content,
                                        userInfo: ["color":color])
    }
    
    func changeAlpha(alpha: AlphaType) {
        slideArray[currentSlideIndex].content?.changeAlpha(alpha: alpha)
        NotificationCenter.default.post(name: Notification.Name.alphaChanged, object: slideArray[currentSlideIndex].content,
                                        userInfo: ["alpha":alpha])
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


extension Notification.Name {
    static let colorChanged = Notification.Name("colorChanged")
    static let alphaChanged = Notification.Name("alphaChanged")
    static let slideAdded = Notification.Name("slideAdded")
}
