import Foundation

protocol Slidable {
    associatedtype Content: Contentable
    var id: String { get }
    var content: Content { get }
}

extension Slidable where Content: SquareContent {
    var description: String {
        return "\(id.subString(from: 0, to: 2))-\(id.subString(from: 3, to: 5))-\(id.subString(from: 6, to: 8)), Side:\(content.side), R:\(content.rgbColor.red), G:\(content.rgbColor.green), B:\(content.rgbColor.blue), Alpha: \(String(content.alpha.rawValue))"
    }
    
    func changeRGB(rgbColor: RGBColor) {
        content.changeRGBColor(color: rgbColor)
    }
}
