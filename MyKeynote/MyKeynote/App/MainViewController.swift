//
//  ViewController.swift
//  MyKeynote
//
//  Created by 이수민 on 2023/07/17.
//

import UIKit

class MainViewController: UIViewController {
    
    let squareSlideFactory = SquareSlideFactory()

    var grayBackGroundView: UIView!
    var slideView: UIView!
    var leftSideView: LeftSideView!
    var rightSideView: RightSideView!
    var squareView: SquareView?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        squareSlideFactory.getFourSquareSlide()
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        ConstantSize.safeAreaHeight = view.safeAreaInsets.top
        ConstantSize.totalHeight -= ConstantSize.safeAreaHeight
        ConstantSize.paddingHeight = (ConstantSize.totalHeight - ConstantSize.middleViewHeight) / 2
    }
  
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        initUI()
        getRandomSquareSlideView()
        configurateUI()
        addSubViews()
    }
    
    func initUI() {
        grayBackGroundView = UIView()
        slideView = UIView()
        leftSideView = LeftSideView()
        rightSideView = RightSideView()
    }
    
    func getRandomSquareSlideView() {
        if let squareSlide = squareSlideFactory.getRandomSlide() as? SquareSlide {
            squareView = SquareView(square: squareSlide)
        }
    }
    
    func configurateUI() {
        view.backgroundColor = UIColor(named: "SuperViewColor")
        grayBackGroundView.backgroundColor = UIColor(named: "SubViewColor")
        grayBackGroundView.frame = CGRect(x: 0, y: ConstantSize.safeAreaHeight, width: ConstantSize.totalWidth, height: ConstantSize.totalHeight )
        slideView.backgroundColor = .white
        slideView.frame = CGRect(x: ConstantSize.sideViewWidth, y: ConstantSize.paddingHeight, width: ConstantSize.middleViewWidth, height: ConstantSize.middleViewHeight)
    }

    func addSubViews() {
        view.addSubview(grayBackGroundView)
        grayBackGroundView.addSubview(slideView)
        grayBackGroundView.addSubview(leftSideView)
        grayBackGroundView.addSubview(rightSideView)
        if let subView = squareView {
            slideView.addSubview(subView)
        }
    }
    
    func addGestureRecognizerToRightSideView() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
        rightSideView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func didTapView(_ sender: UITapGestureRecognizer) {
        
    }
}

