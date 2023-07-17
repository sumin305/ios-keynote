import Foundation

enum AlphaType: Int, CaseIterable {
    case one = 1
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case ten
    
    static func randomAlphaType() -> AlphaType {
        return AlphaType.allCases.randomElement()!
    }
}

struct RGBColor {
    private(set) var red: Int
    private(set) var green: Int
    private(set) var blue: Int
    
    init(red: Int, green: Int, blue: Int) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    
    static func randomNumberInRange() -> Int {
        return Int.random(in: 0...256)
    }
    
    static func randomRGBColor() -> RGBColor {
        return RGBColor(red: randomNumberInRange(), green: randomNumberInRange(), blue: randomNumberInRange())
    }
}

protocol Square {
    var rgb: RGBColor { get set}
    var alpha: AlphaType { get set }
    var side: Int { get set }
}

protocol Slidable {
    var id: String { get set }
}

protocol SquareSlidable: Square, Slidable {
    
}

extension String {
    func subString(from: Int, to: Int) -> String {
        guard from < count, to >= 0, to - from >= 0 else { return "" }
        let startIndex = self.index(self.startIndex, offsetBy: from)
        let endIndex = self.index(self.startIndex, offsetBy: to + 1)
        
        return String(self[startIndex..<endIndex])
    }
}
