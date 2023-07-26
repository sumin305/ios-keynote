import UIKit

class MainViewController: UIViewController {
    
    var slideManager: SlideManager!
    var mainView: MainView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        slideManager = SlideManager()
        slideManager.getFourSquareSlide() // 미션 3-1 수행
        slideManager.addRandomSlide() //메인뷰에 메서드 만들어라
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        ConstantSize.safeAreaHeight = view.safeAreaInsets.top
        ConstantSize.totalHeight -= ConstantSize.safeAreaHeight
        ConstantSize.paddingHeight = (ConstantSize.totalHeight - ConstantSize.middleViewHeight) / 2
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mainView = MainView(slides: slideManager.getSlides(), selectedIndex: slideManager.getSlideIndex())
        view.backgroundColor = UIColor(named: "SuperViewColor")
        view.addSubview(mainView)
        mainView.setSubViewDelegate(delegatable: self)
    }
}
// MARK: - 이벤트 설정
extension MainViewController: UIColorPickerViewControllerDelegate, TapGestureDelegate, ContentPropertyViewDelegate {

    func colorPickerButtonTapped() {
        let backGroundColorPicker = UIColorPickerViewController()
        backGroundColorPicker.title = "배경색"
        backGroundColorPicker.supportsAlpha = false
        backGroundColorPicker.delegate = self
        backGroundColorPicker.modalPresentationStyle = .popover
//        backGroundColorPicker.popoverPresentationController?.sourceView = mainView.contentPropertyView.backGroundColorPickerButton
        present(backGroundColorPicker, animated: true, completion: nil)
    }
    
    // MARK: - 색상 변경
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        let squareSlideContent = (slideManager.getSlides()[slideManager.getSlideIndex()].content as! SquareContent)
        let color = viewController.selectedColor
        // Model
        slideManager.changeRGBColor(color: RGBColor(red: color.redToUInt8, green: color.greenToUInt8, blue: color.blueToUInt8))
        
        // view
        mainView.changeContentViewBackgroundColor(color: color.withAlphaComponent(squareSlideContent.alpha.alphaValue))
       
        mainView.changeContentPropertyViewColor(color: color)
        mainView.changeContentPropertyViewColorText(text: color.hexadecimal)
    }
    
    // MARK: - Stepper 변경
    func stepperPressed(value: Int) {
        // Model
        slideManager.changeAlpha(alpha: AlphaType(rawValue: value) ?? .one)
        // View
        mainView.changeContentViewAlpha(alpha: AlphaType(rawValue: value)!)
        mainView.changeAlphaText(text: String(value))
    }

    // MARK: - 정사각형 클릭
    func tapGestureRecognized(_ sender: UITapGestureRecognizer, frame: CGRect) {
        let tapLocation = sender.location(in: mainView)
        let targetFrame = frame
        
        if targetFrame.contains(tapLocation) {
            changeViewByContentClicked(isContentClicked: true)
        } else {
            changeViewByContentClicked(isContentClicked: false)
        }
    }

    func changeViewByContentClicked(isContentClicked: Bool) {
        let content = slideManager.getContent()
        if isContentClicked {
            if let c = content as? SquareContent {
                mainView.enableContentPropertyViewColor(color: UIColor(color: c.rgbColor, alpha: .one))
            }
            mainView.enableContentPropertyViewAlpha(alpha: content.alpha)
            mainView.enableContentViewBorder()
        } else {
            mainView.disableContentViewBorder()
        }
    }
}

