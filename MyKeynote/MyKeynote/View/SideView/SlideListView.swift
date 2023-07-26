import Foundation
import UIKit

final class SlideListView: SideView {
    
    var slideArray: [any Slidable]

    init(slideArray: [any Slidable]) {
        self.slideArray = slideArray
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setFrame() {
        frame = CGRect(x: 0, y: 0, width: ConstantSize.sideViewWidth, height: ConstantSize.totalHeight)
    }
}
