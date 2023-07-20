import Foundation

protocol Slidable {
    var id: String { get }
    var alpha: AlphaType { get }
    
    func changeAlpha(alpha: AlphaType)
}

protocol SquareSlidable: Slidable, CustomStringConvertible {
    var rgb: RGBColor { get }
    var side: Int { get }
    
    func changeRGB(rgb: RGBColor)
}

extension SquareSlidable {
    var description: String {
        return "\(id.subString(from: 0, to: 2))-\(id.subString(from: 3, to: 5))-\(id.subString(from: 6, to: 8)), Side:\(side), R:\(rgb.red), G:\(rgb.green), B:\(rgb.blue), Alpha: \(String(alpha.rawValue))"
    }
}
