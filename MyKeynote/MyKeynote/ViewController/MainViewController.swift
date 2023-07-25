import UIKit

class MainViewController: UIViewController {
    
    var slideManager: SlideManager!
    var mainView: MainView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        slideManager = SlideManager()
        slideManager.getFourSquareSlide() // 미션 3-1 수행
        slideManager.addRandomSlide()
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        ConstantSize.safeAreaHeight = view.safeAreaInsets.top
        ConstantSize.totalHeight -= ConstantSize.safeAreaHeight
        ConstantSize.paddingHeight = (ConstantSize.totalHeight - ConstantSize.middleViewHeight) / 2
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mainView = MainView(slideManager: slideManager)
        view.backgroundColor = UIColor(named: "SuperViewColor")
        view.addSubview(mainView)
        mainView.setDelegate(viewController: self)
    }
    
}
// MARK: - 이벤트 설정
extension MainViewController: UIColorPickerViewControllerDelegate, ContentPropertyViewDelegate, SlideViewDelegate {

    func colorPickerButtonTapped() {
        let backGroundColorPicker = UIColorPickerViewController()
        backGroundColorPicker.title = "배경색"
        backGroundColorPicker.supportsAlpha = false
        backGroundColorPicker.delegate = self
        backGroundColorPicker.modalPresentationStyle = .popover

        backGroundColorPicker.popoverPresentationController?.sourceView = mainView.contentPropertyView.backGroundColorPickerButton
        present(backGroundColorPicker, animated: true, completion: nil)
    }
    
    // MARK: - 색상 변경
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        let squareSlideContent = (slideManager.slideArray[slideManager.currentSlideIndex].content as! SquareContent)
        let color = viewController.selectedColor
        // Model
        slideManager.changeRGBColor(color: RGBColor(red: color.redToUInt8, green: color.greenToUInt8, blue: color.blueToUInt8))
        // view
        (mainView.slideView.contentView as? SquareContentView)?.changeBackgroundColor(color: color.withAlphaComponent((squareSlideContent.alpha.alphaValue)))
        mainView.contentPropertyView.changeContent(content: squareSlideContent)
        print((slideManager.slideArray[slideManager.currentSlideIndex] as! SquareSlide).description)

    }
    
    // MARK: - Stepper 변경
    func stepperPressed(value: Int) {
        // Model
        slideManager.changeAlpha(alpha: AlphaType(rawValue: value) ?? .one)
        // View
        (mainView.slideView.contentView).changeAlphaValue(value: value)
        mainView.contentPropertyView.alphaView.text = "\(slideManager.getContentAlpha().rawValue)"
    }

    // MARK: - 정사각형 클릭
    func tapGestureRecognized(_ sender: UITapGestureRecognizer) {
        let tapLocation = sender.location(in: mainView.slideView)
        let targetFrame = mainView.slideView.contentView?.frame
        
        if targetFrame!.contains(tapLocation) {
            changeViewByContentClicked(isContentClicked: true)
        } else {
            changeViewByContentClicked(isContentClicked: false)
        }
    }

    func changeViewByContentClicked(isContentClicked: Bool) {
        let content = slideManager.getContent()

        mainView.contentPropertyView.changeSideContent(content: content, isSquareClicked: isContentClicked)
        (mainView.slideView.contentView)?.changeBorder(isClicked: isContentClicked)
    }
}

