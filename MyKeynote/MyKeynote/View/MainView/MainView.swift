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
        super.init(coder: coder)
    }
    
    func initUI(slides: [any Slidable], selectedIndex: Int) {
        slideView = SlideView(slide: slides[selectedIndex])
        contentPropertyView = ContentPropertyView(content: slides[selectedIndex].content ?? ImageContent(alpha: .one, height: 100, width: 100))
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
    
    // MARK: - 하위 뷰 Delegate 등록 -> ANYOBJECT 사용하지 말자 ..
    func setSubViewDelegate(delegatable: AnyObject) {
        setContentPropertyViewDelegate(delegatable: delegatable)
        setTapGestureDelegate(delegatable: delegatable)
        setSlideAddButtonDelegate(delegatable: delegatable)
        setSlideListTableViewDataSource(delegatable: delegatable)
    }
    func setContentPropertyViewDelegate(delegatable: AnyObject) {
        contentPropertyView.setContentPropertyViewDelegate(delegatable: delegatable as! ContentPropertyViewDelegate)
    }
    
    func setTapGestureDelegate(delegatable: AnyObject) {
        slideView.setTapGestureDelegate(delegatable: delegatable as! TapGestureDelegate)
    }
    
    func setSlideAddButtonDelegate(delegatable: AnyObject) {
        slideListView.setSlideAddButtonDelegate(delegatable: delegatable as! SlideListViewDelegate)
    }
    
    func setSlideListTableViewDataSource(delegatable: AnyObject) {
        slideListView.setSlideListTableViewDataSource(delegatable: delegatable as! UITableViewDataSource)
        
        slideListView.setSlideListTableDelegate(delegatable: delegatable as! UITableViewDelegate)
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
    // MARK: - 슬라이드 추가
    func updateSlideList(slide: any Slidable) {
        slideListView.updateSlideList(slide: slide)
    }
    
    func redrawSlideView(slide: any Slidable) {
        slideView = SlideView(slide: slide)
        addSubview(slideView)
    }
    
    func redrawContentPropertyView(text: String, color: UIColor) {
        contentPropertyView.changeAlphaText(text: text)
        contentPropertyView.changeContentPropertyViewColor(color: color)
        contentPropertyView.changeContentPropertyViewColorText(text: color.hexadecimal)
        
    }
}
