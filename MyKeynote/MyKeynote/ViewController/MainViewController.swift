import UIKit

class MainViewController: UIViewController {
    
    var slideManager: SlideManager!
    var mainView: MainView!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        slideManager = SlideManager()
        slideManager.getFourSquareSlide() // 미션 3-1 수행
        slideManager.addRandomSlide() //메인뷰에 메서드 만들어라
        NotificationCenter.default.addObserver(self, selector: #selector(didAlphaChanged), name: Notification.Name.alphaChanged, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didColorChanged), name: Notification.Name.colorChanged, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didSlideAdded), name: Notification.Name.slideAdded, object: nil)
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
extension MainViewController: UIColorPickerViewControllerDelegate, TapGestureDelegate, ContentPropertyViewDelegate, SlideListViewDelegate {

    func colorPickerButtonTapped(sourceButton: UIView) {
        let backGroundColorPicker = UIColorPickerViewController()
        backGroundColorPicker.title = "배경색"
        backGroundColorPicker.supportsAlpha = false
        backGroundColorPicker.delegate = self
        backGroundColorPicker.modalPresentationStyle = .popover
        backGroundColorPicker.popoverPresentationController?.sourceView = sourceButton
        present(backGroundColorPicker, animated: true, completion: nil)
    }
    
    // MARK: - 색상 변경
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        let color = viewController.selectedColor
        // Model
        slideManager.changeRGBColor(color: RGBColor(red: color.redToUInt8, green: color.greenToUInt8, blue: color.blueToUInt8))
    }
    
    // MARK: - Stepper 변경
    func stepperPressed(value: Int) {
        // Model
        slideManager.changeAlpha(alpha: AlphaType(rawValue: value) ?? .one)
    }

    // MARK: - 정사각형 클릭
    func tapGestureRecognized(_ sender: UITapGestureRecognizer, view: UIView, frame: CGRect) {
        let tapLocation = sender.location(in: view)
        let targetFrame = frame
        
        if targetFrame.contains(tapLocation) {
            enableView()
        } else {
            disableView()
        }
    }

    func enableView() {
        let content = slideManager.getContent()
        if let c = content as? SquareContent {
            mainView.enableContentPropertyViewColor(color: UIColor(color: c.rgbColor, alpha: .one))
        }
        mainView.enableContentPropertyViewAlpha(alpha: content.alpha)
        mainView.enableContentViewBorder()
    }
    
    func disableView() {
        mainView.disableContentPropertyView()
        mainView.disableContentViewBorder()
    }
    
    // MARK: - 슬라이드 추가 버튼 클릭
    func addSlide() {
        slideManager.addRandomSlide()
    }

    @objc func didAlphaChanged(_ sender: Notification) {
        
        guard let value = (sender.userInfo?["alpha"] as? AlphaType)?.rawValue else { return }
        
        mainView.changeContentViewAlpha(alpha: AlphaType(rawValue: value)!)
        mainView.changeAlphaText(text: String(value))
    }
    
    @objc func didColorChanged(_ sender: Notification) {
        guard let rgbColor = sender.userInfo?["color"] as? RGBColor else { return }
        let color = UIColor(color: rgbColor, alpha: .one)
        let squareSlideContent = (slideManager.getSlides()[slideManager.getSlideIndex()].content as! SquareContent)
        
        mainView.changeContentViewBackgroundColor(color: color.withAlphaComponent(squareSlideContent.alpha.alphaValue))
       
        mainView.changeContentPropertyViewColor(color: color)
        mainView.changeContentPropertyViewColorText(text: color.hexadecimal)
    }
    
    @objc func didSlideAdded(_ sender: Notification) {
        print("@@@@@@@@@@@")
        slideManager.getSlides().forEach{ print(($0 as! SquareSlide).description) }
    }
}

