import Foundation
import OSLog

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
        return ImageSlide(id: idManager.makeRandomID())
    }
}

protocol SlideFactory {
    func getRandomSlide() -> any Slidable
}


final class IDManager {
    static let shared = IDManager()
    
    private init() { }
    private var uniqueIDSet: Set<String> = []
    
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
