import Foundation
import UIKit

protocol ContentPropertyViewDelegate: AnyObject {
    func colorPickerButtonTapped()
    func stepperPressed(value: Int)
}

final class ContentPropertyView: SideView, UIColorPickerViewControllerDelegate {
    var content: any Contentable
    
    weak var delegate: ContentPropertyViewDelegate?
    
    let backGroundColorLabel = UILabel()
    let backGroundColorPickerButton = UIButton(type: .system)
    let alphaLabel = UILabel()
    let alphaView = UILabel()
    let stepperView = UIStepper()
    var backGroundColorPickerButtonTitle = ""
    
    init(content: any Contentable) {
        self.content = content
        super.init()
        setBackGroundColorLabel()
        setBackGroundColorPickerButton()
        setAlphaLabel()
        setAlphaView()
        setStepperView()
        addRightSideSubviews()
        addTarget()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setFrame() {
        frame = CGRect(x: ConstantSize.sideViewWidth + ConstantSize.middleViewWidth, y: 0, width: ConstantSize.sideViewWidth, height: ConstantSize.totalHeight)
    }
    
    func setBackGroundColorLabel() {
        backGroundColorLabel.frame = CGRect(x: ConstantSize.padding, y: ConstantSize.padding, width: ConstantSize.sideViewWidth - 2*ConstantSize.padding, height: ConstantSize.contentHeight)
        backGroundColorLabel.text = "배경색"
        backGroundColorLabel.textColor = .black
        backGroundColorLabel.font = UIFont(name: "", size: ConstantSize.contentHeight)
    }
    
    func setBackGroundColorPickerButton() {
        backGroundColorPickerButton.setTitle(backGroundColorPickerButtonTitle, for: .normal)
        backGroundColorPickerButton.tintColor = .black
        backGroundColorPickerButton.frame = CGRect(x: ConstantSize.padding, y: ConstantSize.padding + ConstantSize.contentHeight, width: ConstantSize.sideViewWidth - 2*ConstantSize.padding, height: ConstantSize.contentHeight)
        backGroundColorPickerButton.layer.cornerRadius = ConstantSize.cornerRadius
        backGroundColorPickerButton.isEnabled = false
    }
    
    func setAlphaLabel() {
        alphaLabel.frame = CGRect(x: ConstantSize.padding, y: ConstantSize.padding + ConstantSize.contentHeight * 2, width: ConstantSize.sideViewWidth - 2*ConstantSize.padding, height: ConstantSize.contentHeight)
        alphaLabel.text = "투명도"
        alphaLabel.textColor = .black
        alphaLabel.font = UIFont(name: "", size: ConstantSize.contentHeight)
    }
    
    func setAlphaView() {
        alphaView.frame = CGRect(x: ConstantSize.padding, y: ConstantSize.padding + ConstantSize.contentHeight * 3, width: (ConstantSize.sideViewWidth - 2*ConstantSize.padding) / 3, height: ConstantSize.contentHeight)
        alphaView.text = ""
        alphaView.textColor = .black
        alphaView.clipsToBounds = true
        alphaView.layer.cornerRadius = ConstantSize.cornerRadius

        alphaView.font = UIFont(name: "", size: ConstantSize.contentHeight)
        alphaView.backgroundColor = .white
        alphaView.textAlignment = .right
    }
    
    func setStepperView() {
        stepperView.frame = CGRect(x: ConstantSize.padding*2 + (ConstantSize.sideViewWidth - 2*ConstantSize.padding) / 3, y: ConstantSize.padding + ConstantSize.contentHeight * 3, width: (ConstantSize.sideViewWidth - 2*ConstantSize.padding) / 3 * 2, height: ConstantSize.contentHeight)
        stepperView.value = Double(content.alpha.rawValue)
        stepperView.maximumValue = 10
        stepperView.minimumValue = 1
        stepperView.stepValue = 1
        stepperView.isEnabled = false
    }
    
    func addRightSideSubviews() {
        self.addSubview(backGroundColorLabel)
        self.addSubview(backGroundColorPickerButton)
        self.addSubview(alphaLabel)
        self.addSubview(alphaView)
        self.addSubview(stepperView)
    }
    
    func addTarget() {
        backGroundColorPickerButton.addTarget(self, action: #selector(colorPickerButtonTapped), for: .touchUpInside)
        stepperView.addTarget(self, action: #selector(stepperPressed), for: .touchUpInside)
    }
    
    func changeSideContent(content: Contentable, isSquareClicked: Bool) {
        if isSquareClicked {
            changeContent(content: content)
        } else {
            resetContent()
        }
        stepperView.isEnabled = isSquareClicked
        backGroundColorPickerButton.isEnabled = isSquareClicked
    }
    
    func changeContent(content: Contentable) {
        if content.type == .square {
            let color = (content as! SquareContent).rgbColor
            backGroundColorPickerButtonTitle = color.hexadecimal
            alphaView.text = "\((content as! SquareContent).alpha.rawValue)"
            setBackGroundColorPickerButton()
            backGroundColorPickerButton.isEnabled = true
            backGroundColorPickerButton.backgroundColor = UIColor(color: color, alpha: .one)
        }
    }
    
    func resetContent() {
        alphaView.text = ""
        backGroundColorPickerButtonTitle = ""
        setBackGroundColorPickerButton()
        backGroundColorPickerButton.backgroundColor = UIColor(named: "SideViewColor")
    }
    
    @objc func colorPickerButtonTapped() {
        delegate?.colorPickerButtonTapped()
    }
    
    @objc func stepperPressed(_ sender: UIStepper) {
        delegate?.stepperPressed(value: Int(sender.value))
    }
}
