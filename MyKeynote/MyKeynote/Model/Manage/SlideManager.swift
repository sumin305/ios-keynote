import Foundation

final class SlideManager: SlideManagable {
    
    typealias Slide = Slidable
    
    // 사진 Slide 생길 경우, Factory Producer 하나만 갖도록
    let squareSlideFactory = SquareSlideFactory.shared
    var slideArray: [Slide] = []
    
    func getFourSquareSlide() {
        squareSlideFactory.getFourSquareSlide()
    }
    func addSlide() {
        slideArray.append(squareSlideFactory.getRandomSlide())
    }
    
    func getSlideCount() -> Int {
        return slideArray.count
    }
    
    subscript(index: Int) -> Slide? {
        guard index < slideArray.count else { return nil }
        return slideArray[index]
    }
}
    
protocol SlideManagable {
    associatedtype Slide
    var slideArray: [Slide] { get set }
    func addSlide()
    func getSlideCount() -> Int
    subscript(index: Int) -> Slide? { get }
}
