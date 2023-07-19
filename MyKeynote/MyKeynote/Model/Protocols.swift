import Foundation

protocol Square {
    var rgb: RGBColor { get set}
    var alpha: AlphaType { get set }
    var side: Int { get set }
}

protocol Slidable {
    var id: String { get }
}

protocol SquareSlidable: Square, Slidable, CustomStringConvertible { }

extension SquareSlidable {
    var description: String {
        return "\(id.subString(from: 0, to: 2))-\(id.subString(from: 3, to: 5))-\(id.subString(from: 6, to: 8)), Side:\(side), R:\(rgb.red), G:\(rgb.green), B:\(rgb.blue), Alpha: \(String(alpha.rawValue))"
    }
}
