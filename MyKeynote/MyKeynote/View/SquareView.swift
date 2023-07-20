//
//  SquareView.swift
//  MyKeynote
//
//  Created by 이수민 on 2023/07/18.
//

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
    
    // MARK: - 하윙
    func setBackgroundColor(rgb: RGBColor, alpha: AlphaType) {
        backgroundColor = UIColor(red: CGFloat(rgb.red)/255, green: CGFloat(rgb.green)/255, blue: CGFloat(rgb.blue)/255, alpha: CGFloat(Double(alpha.rawValue) * 0.1))
    }
}
