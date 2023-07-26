import Foundation
import UIKit

protocol ContentView: UIView {
    var content: any Contentable { get set }
    func setFrame()
    func changeAlphaValue(alpha: AlphaType)
    func changeBorder(isClicked: Bool)
}

final class SquareContentView: UIView, ContentView {
    
    var content: any Contentable
    init(content: any Contentable) {
        self.content = content
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        setFrame()
        setBackgroundColor()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setFrame() {
        let side = (content as! SquareContent).side
        frame = CGRect(x: Int(ConstantSize.middleViewWidth/2 - CGFloat(side/2)), y: Int(ConstantSize.middleViewHeight/2 - CGFloat(side/2)), width: side, height: side)
    }
    
    // MARK: - Color Pick 되었을 때
    func setBackgroundColor() {
        let square = (content as! SquareContent)
        backgroundColor = UIColor(color: square.rgbColor, alpha: square.alpha)
    }
    
    func changeBackgroundColor(color: UIColor) {
        backgroundColor = color
    }
    
    func changeAlphaValue(alpha: AlphaType) {
        // alpha가 변할 때 border의 투명도도 변하지 않도록 alpha = 이렇게 안하고 backgroundColor 변경
        backgroundColor = self.backgroundColor?.withAlphaComponent(alpha.alphaValue)
    }
    
    func changeBorder(isClicked: Bool) {
        if isClicked {
            layer.borderWidth = 5
            layer.borderColor = UIColor.black.cgColor
        } else {
            layer.borderWidth = 0
        }
    }
}
