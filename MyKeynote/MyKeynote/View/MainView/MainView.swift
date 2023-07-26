import Foundation
import UIKit

final class MainView: UIView {
    
    private var slideView: SlideView!
    private var slideListView: SlideListView!
    private var contentPropertyView: ContentPropertyView!
    
    // 뷰에 slideManager를 넘겨주지 않고, Notification Center, property 넘겨주기~
    init(slides: [any Slidable], selectedIndex: Int) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        initUI(slides: slides, selectedIndex: selectedIndex)
        configurateUI()
        addSubViews()
        backgroundColor = UIColor(named: "SubViewColor")
        frame = CGRect(x: 0, y: ConstantSize.safeAreaHeight, width: ConstantSize.totalWidth, height: ConstantSize.totalHeight )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI(slides: [any Slidable], selectedIndex: Int) {
        slideView = SlideView(slide: slides[selectedIndex])
        contentPropertyView = ContentPropertyView(content: slides[selectedIndex].content!)
        slideListView = SlideListView(slideArray: slides)
    }
    
    func configurateUI() {
        backgroundColor = .white
        frame = CGRect(x: ConstantSize.sideViewWidth, y: ConstantSize.paddingHeight, width: ConstantSize.middleViewWidth, height: ConstantSize.middleViewHeight)
    }
    
    func addSubViews() {
        addSubview(slideView)
        addSubview(slideListView)
        addSubview(contentPropertyView)
    }
    
    // MARK: - 하위 뷰 Delegate 등록
    func setSubViewDelegate(delegatable: AnyObject) {
        setContentPropertyViewDelegate(delegatable: delegatable)
        setTapGestureDelegate(delegatable: delegatable)
    }
    func setContentPropertyViewDelegate(delegatable: AnyObject) {
        contentPropertyView.setContentPropertyViewDelegate(delegatable: delegatable as! ContentPropertyViewDelegate)
    }
    
    func setTapGestureDelegate(delegatable: AnyObject) {
        slideView.setTapGestureDelegate(delegatable: delegatable as! TapGestureDelegate)
    }
    // MARK: - Alpha 변경
    func changeContentViewAlpha(alpha: AlphaType) {
        slideView.changeContentViewAlpha(alpha: alpha)
    }
    
    func changeAlphaText(text: String) {
        contentPropertyView.changeAlphaText(text: text)
    }
    // MARK: - 정사각 슬라이드 색 변경
    func changeContentViewBackgroundColor(color: UIColor) {
        slideView.changeContentBackgroundColor(color: color)
    }
    func changeContentPropertyViewColor(color: UIColor) {
        contentPropertyView.changeContentPropertyViewColor(color: color)
    }
    func changeContentPropertyViewColorText(text: String) {
        contentPropertyView.changeContentPropertyViewColorText(text: text)
    }
    // MARK: - 활성/ 비활성
    func enableContentPropertyViewColor(color: UIColor) {
        contentPropertyView.enableContentPropertyViewColor(color: color)
    }
    func enableContentPropertyViewAlpha(alpha: AlphaType) {
        contentPropertyView.enableContentPropertyViewAlpha(alpha: alpha)
    }
    
    func enableContentViewBorder() {
        slideView.enableContentViewBorder()
    }
    
   func disableContentPropertyView() {
            contentPropertyView.disableContentPropertyView()
    }
    
    func disableContentViewBorder() {
        slideView.disableContentViewBorder()
    }
    
    
}
