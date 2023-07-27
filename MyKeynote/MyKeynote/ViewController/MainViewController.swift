import UIKit

class MainViewController: UIViewController {
    
    var slideManager = SlideManager()
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
        addObservers()
        setMainView()
        setSubViewDelegate()
    }
    
    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(didAlphaChange), name: Notification.Name.alphaChanged, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didColorChange), name: Notification.Name.colorChanged, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didSlideAdd), name: Notification.Name.slideAdded, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didSelectedIndexChange), name: Notification.Name.selectedIndexChanged, object: nil)
    }
    
    func setMainView() {
        mainView = MainView(slide: slideManager.getFirstSlide())
        view.backgroundColor = UIColor(named: "SuperViewColor")
        view.addSubview(mainView)
    }
    
    func setSubViewDelegate() {
        mainView.setContentPropertyViewDelegate(delegatable: self)
        mainView.setTapGestureDelegate(delegatable: self)
        mainView.setSlideAddButtonDelegate(delegatable: self)
        mainView.setSlideListTableViewDataSource(delegatable: self)
        mainView.setSlideListTableViewDelegate(delegatable: self)
    }
}
// MARK: - 이벤트 설정
extension MainViewController: UIColorPickerViewControllerDelegate, TapGestureDelegate, ContentPropertyViewDelegate, SlideListViewDelegate, UITableViewDataSource, UITableViewDelegate {

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
        slideManager.changeRGBColor(color: RGBColor(red: color.redToUInt8, green: color.greenToUInt8, blue: color.blueToUInt8))
    }
    
    // MARK: - Stepper 변경
    func stepperPressed(value: Int) {
        slideManager.changeAlpha(alpha: AlphaType(rawValue: value) ?? .one)
    }

    // MARK: - 정사각형 클릭
    func tapGestureRecognized(_ sender: UITapGestureRecognizer, view: UIView, frame: CGRect) {
        let tapLocation = sender.location(in: view)
        let targetFrame = frame
        if targetFrame.contains(tapLocation) { enableView() }
        else { disableView() }
    }

    func enableView() {
        let content = slideManager.getContent()
        guard let c = content as? SquareContent else { return }
        mainView.enableContentPropertyViewColor(color: UIColor(color: c.rgbColor, alpha: .one))
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

    @objc func didAlphaChange(_ sender: Notification) {
        guard let value = (sender.userInfo?["alpha"] as? AlphaType)?.rawValue else { return }
        mainView.changeContentViewAlpha(alpha: AlphaType(rawValue: value) ?? .one)
        mainView.changeAlphaText(text: String(value))
    }
    
    @objc func didColorChange(_ sender: Notification) {
        guard let rgbColor = sender.userInfo?["color"] as? RGBColor else { return }
        let color = UIColor(color: rgbColor, alpha: .one)
        let squareSlideContent = slideManager.getContent()
        mainView.changeContentViewBackgroundColor(color: color.withAlphaComponent(squareSlideContent.alpha.alphaValue))
        mainView.changeContentPropertyViewColor(color: color)
        mainView.changeContentPropertyViewColorText(text: color.hexadecimal)
    }
    
    @objc func didSlideAdd(_ sender: Notification) {
        guard let slide = sender.userInfo?["slide"] as? (any Slidable) else { return }
        mainView.updateSlideList(slide: slide)
        mainView.redrawSlideView(slide: slide)
        mainView.redrawContentPropertyView(text: String(slide.content.alpha.rawValue),
                                           color: UIColor(color: (slide.content as? SquareContent)?.rgbColor ?? RGBColor(red: 10, green: 10, blue: 10), alpha: slide.content.alpha))
       setSubViewDelegate()
    }
    
    @objc func didSelectedIndexChange(_ sender: Notification) {
        guard let index = sender.userInfo?["index"] as? Int else { return }
        let slide = slideManager.getSlides()[index]
        mainView.redrawSlideView(slide: slide)
        mainView.redrawContentPropertyView(text: String(slide.content.alpha.rawValue),
                                           color: UIColor(color: (slide.content as? SquareContent)?.rgbColor ?? RGBColor(red: 10, green: 10, blue: 10), alpha: slide.content.alpha))
        setSubViewDelegate()
    }
    // MARK: - UITableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return slideManager.getSlideCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CustomCell else { return CustomCell()}
        cell.bind(index: indexPath.row, image: (slideManager[indexPath.row]?.content as? SquareContent) == nil ? "photo.fill" : "rectangle.inset.filled")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CustomCell.Size.cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        slideManager.changeSelectedIndex(index: indexPath[1])
    }
}

