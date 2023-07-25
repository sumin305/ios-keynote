import UIKit

class MainViewController: UIViewController {
    
    let slideManager = SlideManager()
    var mainView: MainView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
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
        view.backgroundColor = UIColor(named: "SuperViewColor")
        mainView = MainView(slideManager: slideManager)
        mainView.backgroundColor = UIColor(named: "SubViewColor")
        mainView.frame = CGRect(x: 0, y: ConstantSize.safeAreaHeight, width: ConstantSize.totalWidth, height: ConstantSize.totalHeight )
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
    
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        let squareSlideContent = (slideManager.slideArray[slideManager.currentSlideIndex].content as! SquareContent)
        let color = viewController.selectedColor
        // Model
        squareSlideContent.changeRGBColor(color: RGBColor(red: color.redToUInt8, green: color.greenToUInt8, blue: color.blueToUInt8))
        // view
        (mainView.slideView.contentView as? SquareContentView)?.changeBackgroundColor(color: color.withAlphaComponent((squareSlideContent.alpha.alphaValue)))
        mainView.contentPropertyView.changeContent(content: squareSlideContent)
    }
    func stepperPressed(value: Int) {
        let content = slideManager.slideArray[slideManager.currentSlideIndex].content
        let value = Int(value)
        // Model
        content?.changeAlpha(alpha: AlphaType(rawValue: value) ?? .one)

        // View
        (mainView.slideView.contentView).changeAlphaValue(value: value)
        mainView.contentPropertyView.alphaView.text = "\(content!.alpha.rawValue)"
    }
    
    func handleTap(_ sender: UITapGestureRecognizer) {
        let tapLocation = sender.location(in: mainView)
        let targetFrame = mainView.slideView.contentView?.frame

        if targetFrame!.contains(tapLocation) {
            changeViewBySquareClicked(isSquareClicked: true)
        } else {
            changeViewBySquareClicked(isSquareClicked: false)
        }
    }
    
    func tapGestureRecognized(_ sender: UITapGestureRecognizer) {
        let tapLocation = sender.location(in: mainView)
        let targetFrame = mainView.slideView.contentView?.frame
        
        if targetFrame!.contains(tapLocation) {
            changeViewBySquareClicked(isSquareClicked: true)
        } else {
            changeViewBySquareClicked(isSquareClicked: false)
        }
    }

    func changeViewBySquareClicked(isSquareClicked: Bool) {
        let content = slideManager.slideArray[slideManager.currentSlideIndex].content

        mainView.contentPropertyView.changeSideContent(content: content!, isSquareClicked: isSquareClicked)
        (mainView.slideView.contentView)?.changeBorder(isClicked: isSquareClicked)
    }
}

