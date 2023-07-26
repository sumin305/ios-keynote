import Foundation

protocol Slidable {
    associatedtype Content: Contentable
    var id: String { get }
    var content: Content? { get }
}

extension Slidable where Content: SquareContent {
    var description: String {
        guard let c = content else { return "" }
        return "\(id.subString(from: 0, to: 2))-\(id.subString(from: 3, to: 5))-\(id.subString(from: 6, to: 8)), Side:\(c.side), R:\(c.rgbColor.red), G:\(c.rgbColor.green), B:\(c.rgbColor.blue), Alpha: \(String(c.alpha.rawValue))"
    }
    
    func changeRGB(rgbColor: RGBColor) {
        guard let c = content else { return }
        c.changeRGBColor(color: rgbColor)
    }
}
