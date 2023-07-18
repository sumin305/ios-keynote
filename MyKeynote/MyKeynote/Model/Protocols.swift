import Foundation

protocol Square {
    var rgb: RGBColor { get set}
    var alpha: AlphaType { get set }
    var side: Int { get set }
}

protocol Slidable {
    var id: String { get }
}

protocol SquareSlidable: Square, Slidable { }

extension String {
    func subString(from: Int, to: Int) -> String {
        guard from < count, to >= 0, to - from >= 0 else { return "" }
        let startIndex = self.index(self.startIndex, offsetBy: from)
        let endIndex = self.index(self.startIndex, offsetBy: to + 1)
        
        return String(self[startIndex..<endIndex])
    }
}
