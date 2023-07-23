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
    
    // MARK: - 이렇게 model값을 uikit에서 사용하는 라이브러리 형태로 자주 변환될 경우..?? model에서 uikit import 하지 말라했는데 어떻게 해결할까????
    func setBackgroundColor(rgb: RGBColor, alpha: AlphaType) {
        backgroundColor = UIColor(color: rgb, alpha: alpha)
    }
    func changeBackgroundColor(color: UIColor) {
        backgroundColor = color
    }
    func changeAlphaValue(value: Int) {
        // alpha가 변할 때 border의 투명도도 변하지 않도록 alpha = 이렇게 안하고 backgroundColor 변경
        backgroundColor = self.backgroundColor?.withAlphaComponent(AlphaType(rawValue: value)!.alphaValue)
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
