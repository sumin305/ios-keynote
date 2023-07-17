import Foundation
import OSLog
final class SquareSlideFactory {
    
    private var differentIdArray: [String] = []
    
    func getFourSquareSlide() {
        for i in 1...4 {
            let randomSquareSlide = getSquareSlide()
            let string: StaticString = "Rect%d %s"
            os_log(string, i, randomSquareSlide.description)
        }
    }
    func getSquareSlide() -> SquareSlide {
        let randomRGB = RGBColor.randomRGBColor()
        let randomAlpha = AlphaType.randomAlphaType()
        let randomId = getRandomDifferentId()
        let randomSide = Int.random(in: 0...1000)
        return SquareSlide(id: randomId, rgb: randomRGB, alpha: randomAlpha, side: randomSide)
    }

    
    func getRandomDifferentId() -> String {
        let stringArray = "abcdefghijklmnopqrstuvwxyz0123456789"
        
        var id: String = ""
        
        
        for _ in 0..<9 {
            id += String(stringArray.randomElement()!)
        }
        
        while differentIdArray.contains(id) {
            id = getRandomDifferentId()
        }
        
        differentIdArray.append(id)
        return id
    }


}
