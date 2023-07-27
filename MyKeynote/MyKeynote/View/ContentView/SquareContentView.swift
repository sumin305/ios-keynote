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
        setFrame(side: (content as? SquareContent)?.side ?? 1)
        enableContentViewBorder()
        setBackgroundColor(color: UIColor(color: (content as? SquareContent)?.rgbColor ?? RGBColor(red: 10, green: 10, blue: 10),
                                          alpha: (content as? SquareContent)?.alpha ?? .one))
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
    
    func changeContentViewAlpha(alpha: AlphaType) {
        backgroundColor = self.backgroundColor?.withAlphaComponent(alpha.alphaValue)
    }
    
    func enableContentViewBorder() {
        layer.borderWidth = 5
        layer.borderColor = UIColor.black.cgColor
    }
    func disableContentViewBorder() {
        layer.borderWidth = 0
    }
}
