import Foundation

struct RGBColor {
    private(set) var red: UInt8
    private(set) var green: UInt8
    private(set) var blue: UInt8
    
    init(red: UInt8, green: UInt8, blue: UInt8) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    
    static func randomNumberInRange() -> UInt8 {
        return UInt8.random(in: 0...255)
    }
    
    static func randomRGBColor() -> RGBColor {
        return RGBColor(red: randomNumberInRange(), green: randomNumberInRange(), blue: randomNumberInRange())
    }
}



