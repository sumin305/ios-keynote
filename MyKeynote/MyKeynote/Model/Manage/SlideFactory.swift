import Foundation
import OSLog

protocol SlideFactory {
    func getRandomSlide() -> any Slidable
}

final class SquareSlideFactory: SlideFactory {
    let idManager = IDManager.shared

    func getFourSquareSlide() {
        for i in 1...4 {
            let randomSquareSlide = getRandomSlide()
            let string: StaticString = "Rect%d %s"
            
            guard let squareSlide = randomSquareSlide as? SquareSlide else { return }
            os_log(string, i, squareSlide.description)
        }
    }
    
    func getRandomSlide() -> any Slidable {
        let randomRGB = RGBColor.random()
        let randomAlpha = AlphaType.random()
        let randomID = idManager.makeRandomID()
        let randomSide = Int.random(in: 0...Int(ConstantSize.middleViewHeight))
        return SquareSlide(id: randomID, content: SquareContent(alpha: randomAlpha, rgbColor: randomRGB, side: randomSide))
    }
}

final class ImageSlideFactory: SlideFactory {
    let idManager = IDManager.shared

    func getRandomSlide() -> any Slidable {
        return ImageSlide(id: idManager.makeRandomID(), content: ImageContent(alpha: .one, height: 100, width: 100))
    }
}


