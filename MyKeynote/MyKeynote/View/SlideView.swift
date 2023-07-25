import UIKit
protocol SlideViewDelegate: AnyObject {
    func tapGestureRecognized(_ sender: UITapGestureRecognizer)
}
final class SlideView: UIView {
    
    weak var delegate: SlideViewDelegate?
    var slide: any Slidable // View에서 모델을 프로퍼티로 가지고 있는게 맞냐?
    var contentView: ContentView!
    
    
    init(slide: any Slidable) {
        self.slide = slide
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        backgroundColor = .white
        frame = CGRect(x: ConstantSize.sideViewWidth, y: ConstantSize.paddingHeight, width: ConstantSize.middleViewWidth, height: ConstantSize.middleViewHeight)
        
        
        let contentViewFactory = ContentViewFactory()
        guard let content = slide.content else { return }
        contentView = contentViewFactory.createContentView(content: content)
        addSubview(contentView)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        delegate?.tapGestureRecognized(sender)
    }
}



