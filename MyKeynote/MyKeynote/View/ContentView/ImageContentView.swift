import Foundation
import UIKit

final class ImageContentView: UIView, ContentView {
    var content: any Contentable

    init(content: any Contentable) {
        self.content = content
        super.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    }
    func setFrame() {
        frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeAlphaValue(alpha: AlphaType) {
        // alpha가 변할 때 border의 투명도도 변하지 않도록 alpha = 이렇게 안하고 backgroundColor 변경
        backgroundColor = self.backgroundColor?.withAlphaComponent(alpha.alphaValue)
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
