import Foundation
import UIKit

class SideView: UIView {
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        backgroundColor = UIColor(named: "SideViewColor")
        setFrame()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setFrame() { }
}

