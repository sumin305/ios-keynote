import Foundation
import UIKit

protocol ContentPropertyViewDelegate: AnyObject {
    func colorPickerButtonTapped(sourceButton: UIView)
    func stepperPressed(value: Int)
}

final class ContentPropertyView: SideView {
    
    enum ContentSize {
        static let contentHeight: CGFloat = 30
        static let cornerRadius: CGFloat = 5
    }
    
    weak var delegate: ContentPropertyViewDelegate?
    
    private let backGroundColorLabel = UILabel()
    private let backGroundColorPickerButton = UIButton(type: .system)
    private let alphaLabel = UILabel()
    private let alphaView = UILabel()
    private let stepperView = UIStepper()
    
    init(content: any Contentable) {
        super.init()
        setBackGroundColorLabel()
        setBackGroundColorPickerButton(content: content)
        setAlphaLabel()
        setAlphaView(content: content)
        setStepperView(content: content)
        addRightSideSubviews()
        addTarget()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func setFrame() {
        frame = CGRect(x: ConstantSize.sideViewWidth + ConstantSize.middleViewWidth, y: 0, width: ConstantSize.sideViewWidth, height: ConstantSize.totalHeight)
    }
    
    func setBackGroundColorLabel() {
        backGroundColorLabel.frame = CGRect(x: ConstantSize.padding, y: ConstantSize.padding, width: ConstantSize.sideViewWidth - 2*ConstantSize.padding, height: ContentSize.contentHeight)
        backGroundColorLabel.text = "배경색"
        backGroundColorLabel.textColor = .black
        backGroundColorLabel.font = UIFont(name: "", size: ContentSize.contentHeight)
    }
    
    func setBackGroundColorPickerButton(content: any Contentable) {
        backGroundColorPickerButton.setTitle(UIColor(color: (content as? SquareContent)?.rgbColor ?? RGBColor(red: 10, green: 10, blue: 10), alpha: .one).hexadecimal, for: .normal)
        backGroundColorPickerButton.tintColor = .black
        backGroundColorPickerButton.backgroundColor = UIColor(color: (content as? SquareContent)?.rgbColor ?? RGBColor(red: 10, green: 10, blue: 10), alpha: .one)
        backGroundColorPickerButton.frame = CGRect(x: ConstantSize.padding, y: ConstantSize.padding + ContentSize.contentHeight, width: ConstantSize.sideViewWidth - 2*ConstantSize.padding, height: ContentSize.contentHeight)
        backGroundColorPickerButton.layer.cornerRadius = ContentSize.cornerRadius
        backGroundColorPickerButton.isEnabled = true
    }
    
    func setAlphaLabel() {
        alphaLabel.frame = CGRect(x: ConstantSize.padding, y: ConstantSize.padding + ContentSize.contentHeight * 2, width: ConstantSize.sideViewWidth - 2*ConstantSize.padding, height: ContentSize.contentHeight)
        alphaLabel.text = "투명도"
        alphaLabel.textColor = .black
        alphaLabel.font = UIFont(name: "", size: ContentSize.contentHeight)
    }
    
    func setAlphaView(content: any Contentable) {
        alphaView.frame = CGRect(x: ConstantSize.padding, y: ConstantSize.padding + ContentSize.contentHeight * 3, width: (ConstantSize.sideViewWidth - 2*ConstantSize.padding) / 3, height: ContentSize.contentHeight)
        alphaView.text = "\(content.alpha.rawValue)"
        alphaView.textColor = .black
        alphaView.clipsToBounds = true
        alphaView.layer.cornerRadius = ContentSize.cornerRadius

        alphaView.font = UIFont(name: "", size: ContentSize.contentHeight)
        alphaView.backgroundColor = .white
        alphaView.textAlignment = .right
    }
    
    func setStepperView(content: any Contentable) {
        stepperView.frame = CGRect(x: ConstantSize.padding*3 + alphaView.frame.width, y: ConstantSize.padding + ContentSize.contentHeight * 3, width: (ConstantSize.sideViewWidth - 2*ConstantSize.padding) / 3 * 3, height: ContentSize.contentHeight)
        stepperView.value = Double(content.alpha.rawValue)
        stepperView.maximumValue = 10
        stepperView.minimumValue = 1
        stepperView.stepValue = 1
        stepperView.isEnabled = true
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
    // MARK: - Alpha 변경
    func changeAlphaText(text: String) {
        alphaView.text = text
    }
    // MARK: - 정사각 슬라이드 색 변경
    func changeContentPropertyViewColor(color: UIColor) {
        backGroundColorPickerButton.backgroundColor = color.withAlphaComponent(1)
    }
    func changeContentPropertyViewColorText(text: String) {
        backGroundColorPickerButton.setTitle(text, for: .normal)
    }
    // MARK: - 활성/ 비활성
    func enableContentPropertyViewColor(color: UIColor) {
        backGroundColorPickerButton.isEnabled = true
        backGroundColorPickerButton.backgroundColor = color
        backGroundColorPickerButton.setTitle(color.hexadecimal, for: .normal)
    }
    
    func enableContentPropertyViewAlpha(alpha: AlphaType) {
        stepperView.isEnabled = true
        alphaView.text = String(alpha.rawValue)
    }
    
    func disableContentPropertyView() {
        alphaView.text = "x"
        backGroundColorPickerButton.setTitle("disabled", for: .disabled)
        backGroundColorPickerButton.backgroundColor = UIColor(named: "SideViewColor")
        stepperView.isEnabled = false
        backGroundColorPickerButton.isEnabled = false
    }
    
  
    func setContentPropertyViewDelegate(delegatable: ContentPropertyViewDelegate) {
        self.delegate = delegatable
    }
    
    @objc func colorPickerButtonTapped() {
        delegate?.colorPickerButtonTapped(sourceButton: backGroundColorPickerButton)
    }
    
    @objc func stepperPressed(_ sender: UIStepper) {
        delegate?.stepperPressed(value: Int(sender.value))
    }

}

