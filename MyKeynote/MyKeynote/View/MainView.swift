import Foundation
import UIKit

final class MainView: UIView {
    
    var slideView: SlideView!
    var slideListView: SlideListView!
    var contentPropertyView: ContentPropertyView!
    
    // 뷰에 slideManager를 넘겨주지 않고, Notification Center, property 넘겨주기~
    init(slideManager: SlideManager) {
        slideListView = SlideListView(slideArray: slideManager.slideArray)
        slideView = SlideView(slide: slideManager.slideArray[slideManager.currentSlideIndex])
        contentPropertyView = ContentPropertyView(content: slideManager.slideArray[slideManager.currentSlideIndex].content!)
        
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        initUI()
        configurateUI()
        addSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initUI() {

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
    
    func setDelegate(viewController: ContentPropertyViewDelegate & SlideViewDelegate) {
        contentPropertyView.delegate = viewController
        slideView.delegate = viewController
    }
}
