import UIKit

extension String {
    func subString(from: Int, to: Int) -> String {
        guard from < count, to >= 0, to - from >= 0 else { return "" }
        let startIndex = self.index(self.startIndex, offsetBy: from)
        let endIndex = self.index(self.startIndex, offsetBy: to + 1)
        return String(self[startIndex..<endIndex])
    }
}

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

extension RGBColor {
    func toUIColor(alpha: AlphaType) -> UIColor {
        return UIColor(red: CGFloat(self.red)/255, green: CGFloat(self.green)/255, blue: CGFloat(self.blue)/255, alpha: alpha.alphaValue)
    }
}
