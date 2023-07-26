import Foundation
import UIKit

final class ImageContentView: UIView, ContentView {
    
    var content: any Contentable

    init(content: any Contentable) {
        self.content = content
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setFrame() {
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
