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
        let randomRGB = getRandomRGB()
        let randomAlpha = getRandomAlpha()
        let randomId = getRandomDifferentId()
        let randomSide = getRandomSide()
        return SquareSlide(id: randomId, rgb: randomRGB, alpha: randomAlpha, side: randomSide)
    }
    
    func getRandomRGB() -> RGBColor {
        let red = Int.random(in: 0...256)
        let green = Int.random(in: 0...256)
        let blue = Int.random(in: 0...256)
        return RGBColor(red: red, green: green, blue: blue)
    }
    
    func getRandomAlpha() -> AlphaType {
        return AlphaType.allCases.randomElement()!
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
    
    func getRandomSide() -> Int {
        return Int.random(in: 0...1000)
    }

}
