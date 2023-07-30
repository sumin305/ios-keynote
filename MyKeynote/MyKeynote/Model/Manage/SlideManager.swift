import Foundation

final class SlideManager {
    
    private var slideArray: [any Slidable] = []
    private var currentSlideIndex: Int = 0
    
    subscript(index: Int) -> (any Slidable)? {
        guard 0..<slideArray.count ~= index else { return nil }
        return slideArray[index]
    }
    
    func produceRandomSlide() -> any Slidable {
        let slideFactory = SlideFactoryProducer.getFactory(contentType: .square) //MARK: - 이미지 추가 시 변경
        return slideFactory.getRandomSlide()
    }
    
    func getFourSquareSlide() {
        let squareSlideFactory = SlideFactoryProducer.getFactory(contentType: .square)
        (squareSlideFactory as? SquareSlideFactory)?.getFourSquareSlide()
    }
    
    func addRandomSlide() {
        let slide = produceRandomSlide()
        slideArray.append(slide)
        currentSlideIndex = getSlideCount() - 1
        NotificationCenter.default.post(name: Notification.Name.slideAdded,
                                        object: self,
                                        userInfo: ["slide":slide, "index":currentSlideIndex])
    }
    
    func changeSelectedIndex(index: Int) {
        currentSlideIndex = index
        NotificationCenter.default.post(name: Notification.Name.selectedIndexChanged, object: self, userInfo: ["index": currentSlideIndex])
    }
    
    func getFirstSlide() -> any Slidable {
        guard !slideArray.isEmpty else { return ImageSlide(id: IDManager.shared.makeRandomID(), content: ImageContent(alpha: .one, height: 10, width: 10))}
        return slideArray[0]
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
        slideArray[currentSlideIndex].content.changeAlpha(alpha: alpha)
        NotificationCenter.default.post(name: Notification.Name.alphaChanged, object: slideArray[currentSlideIndex].content,
                                        userInfo: ["alpha":alpha])
    }
    
    func getContentAlpha() -> AlphaType {
        return (slideArray[currentSlideIndex].content.alpha) 
    }
    
    func getContent() -> Contentable {
        return slideArray[currentSlideIndex].content
    }
    
    func getSlides() -> [any Slidable] {
        return slideArray
    }
    
    func getSlideIndex() -> Int {
        return currentSlideIndex
    }
}

extension Notification.Name {
    static let colorChanged = Notification.Name("colorChanged")
    static let alphaChanged = Notification.Name("alphaChanged")
    static let slideAdded = Notification.Name("slideAdded")
    static let selectedIndexChanged = Notification.Name("selectedIndexChanged")
}
