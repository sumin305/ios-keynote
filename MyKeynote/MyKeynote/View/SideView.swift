
import Foundation
import UIKit

final class LeftSideView: SideView {
    override func setFrame() {
        frame = CGRect(x: 0, y: 0, width: ConstantSize.sideViewWidth, height: ConstantSize.totalHeight)
    }
}

final class RightSideView: SideView {

    let backGroundLabel = UILabel()
    let backGroundColorPicker = UIColorPickerViewController()
    let alphaLabel = UILabel()
    let alphaView = UILabel()
    let addButton  = UIButton(type: .system)
    let subtractButton  = UIButton(type: .system)

    override init() {
        super.init()
        setRightSideSubviewsFrame()
        addRightSideSubviews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func setFrame() {
        frame = CGRect(x: ConstantSize.sideViewWidth + ConstantSize.middleViewWidth, y: 0, width: ConstantSize.sideViewWidth, height: ConstantSize.totalHeight)
    }
    
    func setRightSideSubviewsFrame() {
        backGroundLabel.frame = CGRect(x: ConstantSize.padding, y: ConstantSize.padding, width: ConstantSize.sideViewWidth - 2*ConstantSize.padding, height: 20)
        backGroundLabel.text = "배경색"
        backGroundLabel.textColor = .black
        backGroundLabel.font = UIFont(name: "", size: 20)
        alphaLabel.frame = CGRect(x: ConstantSize.padding, y: ConstantSize.padding + 60, width: ConstantSize.sideViewWidth - 2*ConstantSize.padding, height: 20)
        alphaLabel.text = "투명도"
        alphaLabel.textColor = .black
        alphaLabel.font = UIFont(name: "", size: 20)
    }
    
    func addRightSideSubviews() {
        self.addSubview(backGroundLabel)
        
        self.addSubview(alphaLabel)
        self.addSubview(alphaView)
        
        self.addSubview(addButton)
        self.addSubview(subtractButton)
    }
}

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

