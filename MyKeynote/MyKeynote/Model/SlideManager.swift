//
//  SlideManager.swift
//  MyKeynote
//
//  Created by 이수민 on 2023/07/20.
//

import Foundation

final class SlideManager: SlideManagable {
    typealias Slide = Slidable
    let squareSlideFactory = SquareSlideFactory()
    var slideArray: [Slide] = []
    
    func addSlide() {
        slideArray.append(squareSlideFactory.getRandomSlide())
    }
    
    func getSlideCount() -> Int {
        return slideArray.count
    }
    
    subscript(index: Int) -> Slide? {
        guard index < slideArray.count else { return nil }
        return slideArray[index]
    }
}
    
protocol SlideManagable {
    
    associatedtype Slide
    var slideArray: [Slide] { get set }
    func addSlide()
    func getSlideCount() -> Int
    subscript(index: Int) -> Slide? { get }
    
}
