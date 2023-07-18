import Foundation
import OSLog

final class SquareSlideFactory: SlideFactory {
    
    private var differentIdArray: [String] = []
    
    func getFourSquareSlide() {
        for i in 1...4 {
            let randomSquareSlide = getSlide()
            let string: StaticString = "Rect%d %s"
            
            os_log(string, i, (randomSquareSlide as! SquareSlide).description)
        }
    }
    
    func getSlide() -> Slidable {
        let randomRGB = RGBColor.randomRGBColor()
        let randomAlpha = AlphaType.randomAlphaType()
        let randomId = getId()
        let randomSide = Int.random(in: 0...1000)
        return SquareSlide(id: randomId, rgb: randomRGB, alpha: randomAlpha, side: randomSide)
    }
    
    func getId() -> String {
        let stringArray = "abcdefghijklmnopqrstuvwxyz0123456789"
        
        var id: String = ""
        
        for _ in 0..<9 {
            id += String(stringArray.randomElement()!)
        }
        
        while differentIdArray.contains(id) {
            id = getId()
        }
        
        differentIdArray.append(id)
        return id
    }
}

protocol SlideFactory {
    func getSlide() -> Slidable
    func getId() -> String
}
