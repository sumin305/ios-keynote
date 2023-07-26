import UIKit

enum ConstantSize {
    static var safeAreaHeight: CGFloat = 0
    static let totalWidth = UIScreen.main.bounds.width
    static var totalHeight = UIScreen.main.bounds.height
    static let sideViewWidth: CGFloat = totalWidth / 7
    static let middleViewWidth = totalWidth - (2*sideViewWidth)
    static let middleViewHeight = middleViewWidth * 0.75
    static var paddingHeight = (totalHeight - middleViewHeight) / 2
    static let padding: CGFloat = 5

}
