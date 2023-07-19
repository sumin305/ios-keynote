import Foundation
import OSLog

final class SquareSlideFactory: SlideFactory {
    
    private var uniqueIDSet: Set<String> = []
    
    func getFourSquareSlide() {
        for i in 1...4 {
            let randomSquareSlide = getRandomSlide()
            let string: StaticString = "Rect%d %s"
            
            guard let squareSlide = randomSquareSlide as? SquareSlide else { return }
            os_log(string, i, squareSlide.description)
        }
    }
    
    func getRandomSlide() -> Slidable {
        let randomRGB = RGBColor.random()
        let randomAlpha = AlphaType.random()
        let randomID = makeRandomID()
        let randomSide = Int.random(in: 0...Int(ConstantSize.middleViewHeight))
        return SquareSlide(id: randomID, rgb: randomRGB, alpha: randomAlpha, side: randomSide)
    }
    
    func makeRandomID() -> String {
        let stringArray = "abcdefghijklmnopqrstuvwxyz0123456789"
        var id: String = ""
        for _ in 0..<9 {
            if let randomString = stringArray.randomElement() {
                id += String(randomString)
            }
        }
        while uniqueIDSet.contains(id) {
            id = makeRandomID()
        }
        uniqueIDSet.insert(id)
        return id
    }
}

protocol SlideFactory {
    func getRandomSlide() -> Slidable
    func makeRandomID() -> String
}
