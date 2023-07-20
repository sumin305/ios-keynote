import Foundation
import UIKit

final class RightSideView: SideView, UIColorPickerViewControllerDelegate {
    var squareSlide: SquareSlidable
    let backGroundColorLabel = UILabel()
    let backGroundColorPickerButton = UIButton(type: .system)
    let alphaLabel = UILabel()
    let alphaView = UILabel()
    let stepperView = UIStepper()
    var backGroundColorPickerButtonTitle = ""
    var alphaViewText = ""
    
    init(square: SquareSlidable) {
        squareSlide = square
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
        backGroundColorLabel.frame = CGRect(x: ConstantSize.padding, y: ConstantSize.padding, width: ConstantSize.sideViewWidth - 2*ConstantSize.padding, height: ConstantSize.contentHeight)
        backGroundColorLabel.text = "배경색"
        backGroundColorLabel.textColor = .black
        backGroundColorLabel.font = UIFont(name: "", size: ConstantSize.contentHeight)
    }
    
    func setBackGroundColorPickerButton() {
        backGroundColorPickerButton.setTitle(backGroundColorPickerButtonTitle, for: .normal)
        backGroundColorPickerButton.tintColor = .black
        backGroundColorPickerButton.frame = CGRect(x: ConstantSize.padding, y: ConstantSize.padding + ConstantSize.contentHeight, width: ConstantSize.sideViewWidth - 2*ConstantSize.padding, height: ConstantSize.contentHeight)
        backGroundColorPickerButton.layer.cornerRadius = 5

    }
    
    func setAlphaLabel() {
        alphaLabel.frame = CGRect(x: ConstantSize.padding, y: ConstantSize.padding + ConstantSize.contentHeight * 2, width: ConstantSize.sideViewWidth - 2*ConstantSize.padding, height: ConstantSize.contentHeight)
        alphaLabel.text = "투명도"
        alphaLabel.textColor = .black
        alphaLabel.font = UIFont(name: "", size: ConstantSize.contentHeight)
    }
    
    func setAlphaView() {
        alphaView.frame = CGRect(x: ConstantSize.padding, y: ConstantSize.padding + ConstantSize.contentHeight * 3, width: (ConstantSize.sideViewWidth - 2*ConstantSize.padding) / 3, height: ConstantSize.contentHeight)
        alphaView.text = alphaViewText
        //alphaView.text = "\(squareSlide.alpha.rawValue)"
        alphaView.textColor = .black
        alphaView.clipsToBounds = true
        alphaView.layer.cornerRadius = 5

        alphaView.font = UIFont(name: "", size: ConstantSize.contentHeight)
        alphaView.backgroundColor = .white
        alphaView.textAlignment = .right
    }
    
    func setStepperView() {
        stepperView.frame = CGRect(x: ConstantSize.padding*2 + (ConstantSize.sideViewWidth - 2*ConstantSize.padding) / 3, y: ConstantSize.padding + ConstantSize.contentHeight * 3, width: (ConstantSize.sideViewWidth - 2*ConstantSize.padding) / 3 * 2, height: ConstantSize.contentHeight)
        stepperView.value = Double(squareSlide.alpha.rawValue)
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
    
    func changeSideContent(square: Slidable, isSquareClicked: Bool) {
        if isSquareClicked {
            setTitle(square: square)
        } else {
            resetTitle()
        }
    }
    
    func setTitle(square: Slidable) {
        if let s = square as? SquareSlide {
            let color = s.rgb
            backGroundColorPickerButtonTitle = s.rgb.hexadecimal
            alphaView.text = "\(s.alpha.rawValue)"
            setBackGroundColorPickerButton()
            backGroundColorPickerButton.backgroundColor = UIColor(red: CGFloat(color.red)/255, green: CGFloat(color.green)/255, blue: CGFloat(color.blue)/255, alpha: 1)
        }
    }
    
    func resetTitle() {
        alphaView.text = ""
        backGroundColorPickerButtonTitle = ""
        setBackGroundColorPickerButton()
        backGroundColorPickerButton.backgroundColor = UIColor(named: "SideViewColor")
    }
}
