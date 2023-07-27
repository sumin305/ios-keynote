import UIKit

protocol TapGestureDelegate: AnyObject {
    func tapGestureRecognized(_ sender: UITapGestureRecognizer, view: UIView, frame: CGRect)
}

final class SlideView: UIView {
    
    weak var delegate: TapGestureDelegate?
    private var contentView: ContentView!
    
    init(slide: any Slidable) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        backgroundColor = .white
        frame = CGRect(x: ConstantSize.sideViewWidth, y: ConstantSize.paddingHeight, width: ConstantSize.middleViewWidth, height: ConstantSize.middleViewHeight)
        
        contentView = ContentViewFactory.createSquareContentView(content: slide.content)
        addSubview(contentView)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        delegate?.tapGestureRecognized(sender, view: self, frame: contentView.frame)
    }
    func changeContentViewAlpha(alpha: AlphaType) {
        contentView.changeContentViewAlpha(alpha: alpha)
    }
    func changeContentBackgroundColor(color: UIColor) {
        (contentView as? SquareContentView)?.setBackgroundColor(color: color)
    }
    func enableContentViewBorder() {
        contentView.enableContentViewBorder()
    }
    func disableContentViewBorder() {
        contentView.disableContentViewBorder()
    }
    func setTapGestureDelegate(delegatable: TapGestureDelegate) {
        self.delegate = delegatable
    }
}



