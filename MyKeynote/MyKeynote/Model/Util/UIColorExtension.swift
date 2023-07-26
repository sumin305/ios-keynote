import UIKit

extension UIColor {
    var redToUInt8: UInt8 {
        return UInt8(self.cgColor.components![0]*255)
    }
    var greenToUInt8: UInt8 {
        return UInt8(self.cgColor.components![1]*255)
    }
    var blueToUInt8: UInt8 {
        return UInt8(self.cgColor.components![2]*255)
    }
}

extension UIColor {
    convenience init(color: RGBColor, alpha: AlphaType) {
        self.init(red: CGFloat(color.red)/255, green: CGFloat(color.green)/255, blue: CGFloat(color.blue)/255, alpha: alpha.alphaValue)
    }
}
