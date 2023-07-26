import Foundation
import UIKit

final class MainView: UIView {
    
    var slideView: SlideView!
    var slideListView: SlideListView!
    var contentPropertyView: ContentPropertyView!
    
    // 뷰에 slideManager를 넘겨주지 않고, Notification Center, property 넘겨주기~
    init(slideManager: SlideManager) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        initUI(slideManager: slideManager)
        configurateUI()
        addSubViews()
        backgroundColor = UIColor(named: "SubViewColor")
        frame = CGRect(x: 0, y: ConstantSize.safeAreaHeight, width: ConstantSize.totalWidth, height: ConstantSize.totalHeight )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI(slideManager: SlideManager) {
        slideListView = SlideListView(slideArray: slideManager.slideArray)
        slideView = SlideView(slide: slideManager.slideArray[slideManager.currentSlideIndex])
        contentPropertyView = ContentPropertyView(content: slideManager.slideArray[slideManager.currentSlideIndex].content!)
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
    
    func setContentPropertyViewDelegate(delegatable: ContentPropertyViewDelegate) {
        contentPropertyView.setContentPropertyViewDelegate(delegatable: delegatable)
    }
    
    func setTapGestureDelegate(delegatable: TapGestureDelegate) {
        slideView.setTapGestureDelegate(delegatable: delegatable)
    }
}
