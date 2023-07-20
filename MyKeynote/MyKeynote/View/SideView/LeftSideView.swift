import Foundation
import UIKit

final class LeftSideView: SideView {
    override func setFrame() {
        frame = CGRect(x: 0, y: 0, width: ConstantSize.sideViewWidth, height: ConstantSize.totalHeight)
    }
}
