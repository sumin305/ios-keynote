import Foundation
import UIKit

final class SquareView: UIView {
    
    init(square: SquareSlide) {
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        setFrame(side: square.side)
        setBackgroundColor(rgb: square.rgb, alpha: square.alpha)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setFrame(side: Int) {
        frame = CGRect(x: Int(ConstantSize.middleViewWidth/2 - CGFloat(side/2)), y: Int(ConstantSize.middleViewHeight/2 - CGFloat(side/2)), width: side, height: side)
    }
    
    // MARK: - Color Pick 되었을 때
    func setBackgroundColor(rgb: RGBColor, alpha: AlphaType) {
             backgroundColor = UIColor(red: CGFloat(rgb.red)/255, green: CGFloat(rgb.green)/255, blue: CGFloat(rgb.blue)/255, alpha: alpha.alphaValue)
    }
    func changeBackgroundColor(color: UIColor) {
        backgroundColor = color
    }
    func changeAlphaValue(value: Int) {
        // alpha가 변할 때 border의 투명도도 변하지 않도록..
        backgroundColor = self.backgroundColor?.withAlphaComponent(AlphaType(rawValue: value)!.alphaValue)

    }
    func changeBorder(isSquareClicked: Bool) {
        if isSquareClicked {
            layer.borderWidth = 5
            layer.borderColor = UIColor.black.cgColor
        } else {
            layer.borderWidth = 0
        }
    }
}
