import Foundation
import UIKit

protocol ContentView: UIView {
    func changeContentViewAlpha(alpha: AlphaType)
    func enableContentViewBorder()
    func disableContentViewBorder()
}

final class SquareContentView: UIView, ContentView {
    init(content: any Contentable) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        setFrame(side: (content as! SquareContent).side)
        setBackgroundColor(color: UIColor(color: (content as! SquareContent).rgbColor, alpha: (content as! SquareContent).alpha))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setFrame(side: Int) {
        frame = CGRect(x: Int(ConstantSize.middleViewWidth/2 - CGFloat(side/2)), y: Int(ConstantSize.middleViewHeight/2 - CGFloat(side/2)), width: side, height: side)
    }
    
    // MARK: - Color Pick 되었을 때
    func setBackgroundColor(color: UIColor) {
        backgroundColor = color
    }
    
    func changeBackgroundColor(color: UIColor) {
        backgroundColor = color
    }
    
    func changeContentViewAlpha(alpha: AlphaType) {
        // alpha가 변할 때 border의 투명도도 변하지 않도록 alpha = 이렇게 안하고 backgroundColor 변경
        backgroundColor = self.backgroundColor?.withAlphaComponent(alpha.alphaValue)
    }
    
    func changeContentBackgroundColor(color: UIColor) {
        backgroundColor = color
    }
    
    func enableContentViewBorder() {
        layer.borderWidth = 5
        layer.borderColor = UIColor.black.cgColor
    }
    func disableContentViewBorder() {
        layer.borderWidth = 0
    }
}
