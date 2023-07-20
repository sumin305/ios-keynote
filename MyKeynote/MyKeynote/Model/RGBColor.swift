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
    
    var hexadecimal: String {
        var hexaString = "0x"
        for rgb in [red, green, blue] {
            let mod: Int = Int(rgb % 16)
            let divisor: Int = Int(rgb / 16)
            print(mod, divisor)

            hexaString += (divisor >= 10 ? String(UnicodeScalar(divisor + 55)!) : String(divisor))

            hexaString += (mod >= 10 ? String(UnicodeScalar(mod + 55)!) : String(mod))
        }
        return hexaString
    }
    
    static func randomNumber() -> UInt8 {
        return UInt8.random(in: 0...255)
    }
    
    static func random() -> RGBColor {
        return RGBColor(red: randomNumber(), green: randomNumber(), blue: randomNumber())
    }
}



