import UIKit

class MainViewController: UIViewController, UIColorPickerViewControllerDelegate {
    // MARK: - 뷰 선언
    let slideManager = SlideManager()
    var grayBackGroundView: UIView!
    var slideView: UIView!
    var leftSideView: LeftSideView!
    var rightSideView: RightSideView!
    var squareView: SquareView?
    var squareSlide: SquareSlide!
    var isClicked: Bool = false

    // MARK: - 뷰 설정
    override func viewDidLoad() {
        super.viewDidLoad()
        slideManager.getFourSquareSlide() // 미션 3-1 수행
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        ConstantSize.safeAreaHeight = view.safeAreaInsets.top
        ConstantSize.totalHeight -= ConstantSize.safeAreaHeight
        ConstantSize.paddingHeight = (ConstantSize.totalHeight - ConstantSize.middleViewHeight) / 2
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        getRandomSquareSlideView()
        initUI()
        configurateUI()
        addSubViews()
        addTargets()
    }
    
    func getRandomSquareSlideView() {
        slideManager.addSlide()
        squareSlide = slideManager[0] as? SquareSlide
        rightSideView = RightSideView(slide: squareSlide)
        squareView = SquareView(square: squareSlide)
    }
    
    func initUI() {
        grayBackGroundView = UIView()
        slideView = UIView()
        leftSideView = LeftSideView()
    }
    
    func configurateUI() {
        view.backgroundColor = UIColor(named: "SuperViewColor")
        grayBackGroundView.backgroundColor = UIColor(named: "SubViewColor")
        grayBackGroundView.frame = CGRect(x: 0, y: ConstantSize.safeAreaHeight, width: ConstantSize.totalWidth, height: ConstantSize.totalHeight )
        slideView.backgroundColor = .white
        slideView.frame = CGRect(x: ConstantSize.sideViewWidth, y: ConstantSize.paddingHeight, width: ConstantSize.middleViewWidth, height: ConstantSize.middleViewHeight)
    }
    
    func addTargets() {
        rightSideView.backGroundColorPickerButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        rightSideView.stepperView.addTarget(self, action: #selector(stepperPressed), for: .touchUpInside)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        slideView?.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func addSubViews() {
        view.addSubview(grayBackGroundView)
        grayBackGroundView.addSubview(slideView)
        grayBackGroundView.addSubview(leftSideView)
        grayBackGroundView.addSubview(rightSideView)
        if let subView = squareView {
            slideView.addSubview(subView)
        }
    }
}

// MARK: - 이벤트 설정
extension MainViewController {
    // MARK: - 버튼이 눌렸을 때
    @objc func buttonTapped() {
        let backGroundColorPicker = UIColorPickerViewController()
        backGroundColorPicker.title = "배경색"
        backGroundColorPicker.supportsAlpha = false
        backGroundColorPicker.delegate = self
        backGroundColorPicker.modalPresentationStyle = .popover
        
        // 에러 해결 -> 아래와 같이 PresentationController의 SourceView, SourceRect를 지정해줘야됨!
        backGroundColorPicker.popoverPresentationController?.sourceView = rightSideView.backGroundColorPickerButton
        present(backGroundColorPicker, animated: true, completion: nil)
    }
    // MARK: - 색상이 변경되었을때
    func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
        
        // Model
        changeSquareModelColor(color: viewController.selectedColor)
        
        // view
        updateSquareViewColor(color: viewController.selectedColor)
        updateBackGroundLabel()
    }
    
    func changeSquareModelColor(color: UIColor) {
        squareSlide.changeRGB(rgb: RGBColor(red: color.redToUInt8, green: color.greenToUInt8, blue: color.blueToUInt8))
    }
        
    func updateSquareViewColor(color: UIColor) {
        squareView?.changeBackgroundColor(color: color.withAlphaComponent(squareSlide.alpha.alphaValue))
    }
    
    func updateBackGroundLabel() {
        rightSideView.changeContent(square: squareSlide)
    }
    
    // MARK: - UIStepper로 투명도가 변경되었을 때
    @objc func stepperPressed(_ sender: UIStepper) {
        
        // Model
        changeSquareModelAlphaValue(value: Int(sender.value))
        
        // View
        updateSquareViewAlpha(value: Int(sender.value))
        updateAlphaLabel()
    }
    
    func changeSquareModelAlphaValue(value: Int) {
        squareSlide.changeAlpha(alpha: AlphaType(rawValue: value) ?? .one)
    }
    
    func updateSquareViewAlpha(value: Int) {
        squareView?.changeAlphaValue(value: value)
    }

    func updateAlphaLabel() {
        rightSideView.alphaView.text = "\(squareSlide.alpha.rawValue)"
    }
    
    // MARK: - 정사각형내에 제스쳐가 감지되었을 때
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        let tapLocation = sender.location(in: slideView)
        let targetFrame = squareView?.frame
        
        if targetFrame!.contains(tapLocation) {
            isClicked = true
        } else {
            isClicked = false
        }
        changeViewBySquareClicked(isSquareClicked: isClicked)
    }
    
    func changeViewBySquareClicked(isSquareClicked: Bool) {
        rightSideView.changeSideContent(square: squareSlide, isSquareClicked: isSquareClicked)
        squareView?.changeBorder(isClicked: isSquareClicked)
    }
}
