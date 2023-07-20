
import Foundation
import UIKit

final class LeftSideView: SideView {
    override func setFrame() {
        frame = CGRect(x: 0, y: 0, width: ConstantSize.sideViewWidth, height: ConstantSize.totalHeight)
    }
}

final class RightSideView: SideView, UIColorPickerViewControllerDelegate {

    var squareSlide: SquareSlidable
    var squareAlphaValue: Int
    let backGroundColorLabel = UILabel()
    let backGroundColorPickerButton = UIButton(type: .system)
    let alphaLabel = UILabel()
    let alphaView = UILabel()
    let stepperView = UIStepper()
    
    init(square: SquareSlidable) {
        squareSlide = square
        squareAlphaValue = 11 - squareSlide.alpha.rawValue
        super.init()
        setBackGroundColorLabel()
        setBackGroundColorPickerButton()
        setAlphaLabel()
        setAlphaView()
        setStepperView()
        addRightSideSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setFrame() {
        frame = CGRect(x: ConstantSize.sideViewWidth + ConstantSize.middleViewWidth, y: 0, width: ConstantSize.sideViewWidth, height: ConstantSize.totalHeight)
    }
    
    func setBackGroundColorLabel() {
        backGroundColorLabel.frame = CGRect(x: ConstantSize.padding, y: ConstantSize.padding, width: ConstantSize.sideViewWidth - 2*ConstantSize.padding, height: 30)
        backGroundColorLabel.text = "배경색"
        backGroundColorLabel.textColor = .black
        backGroundColorLabel.font = UIFont(name: "", size: 30)
    }
    
    func setBackGroundColorPickerButton() {
        backGroundColorPickerButton.setTitle("배경색 선택", for: .normal)
        backGroundColorPickerButton.frame = CGRect(x: ConstantSize.padding, y: ConstantSize.padding + 40, width: ConstantSize.sideViewWidth - 2*ConstantSize.padding, height: 30)
    }
    
    func setAlphaLabel() {
        alphaLabel.frame = CGRect(x: ConstantSize.padding, y: ConstantSize.padding + 80, width: ConstantSize.sideViewWidth - 2*ConstantSize.padding, height: 30)
        alphaLabel.text = "투명도"
        alphaLabel.textColor = .black
        alphaLabel.font = UIFont(name: "", size: 30)
    }
    
    func setAlphaView() {
        alphaView.frame = CGRect(x: ConstantSize.padding, y: ConstantSize.padding + 120, width: (ConstantSize.sideViewWidth - 2*ConstantSize.padding) / 3, height: 30)
        alphaView.text = "\(11 - squareSlide.alpha.rawValue)"
        alphaView.textColor = .black
        alphaView.clipsToBounds = true
        alphaView.layer.cornerRadius = 5

        alphaView.font = UIFont(name: "", size: 30)
        alphaView.backgroundColor = .white
        alphaView.textAlignment = .right
    }
    
    func setStepperView() {
        stepperView.frame = CGRect(x: ConstantSize.padding*2 + (ConstantSize.sideViewWidth - 2*ConstantSize.padding) / 3, y: ConstantSize.padding + 120, width: (ConstantSize.sideViewWidth - 2*ConstantSize.padding) / 3 * 2, height: 30)
        stepperView.value = Double(squareAlphaValue)
        stepperView.maximumValue = 10
        stepperView.minimumValue = 1
        stepperView.stepValue = 1
    }
    
    func addRightSideSubviews() {
        self.addSubview(backGroundColorLabel)
        self.addSubview(backGroundColorPickerButton)
        
        self.addSubview(alphaLabel)
        self.addSubview(alphaView)
        self.addSubview(stepperView)
        
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

