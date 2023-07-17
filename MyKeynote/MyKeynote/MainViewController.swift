//
//  ViewController.swift
//  MyKeynote
//
//  Created by 이수민 on 2023/07/17.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let squareSlideFactory = SquareSlideFactory()
        squareSlideFactory.getFourSquareSlide()
        // Do any additional setup after loading the view.
    }


}

