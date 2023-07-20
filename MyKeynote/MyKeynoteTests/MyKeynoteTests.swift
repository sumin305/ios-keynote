//
//  MyKeynoteTests.swift
//  MyKeynoteTests
//
//  Created by 이수민 on 2023/07/17.
//

import XCTest
@testable import MyKeynote

final class MyKeynoteTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    // slideManager 구조체 테스트
    func testSlideManagerGetSlideCountWell() throws {
        let sut = SlideManager()
        
        let slideArray = sut.slideArray
        let count = sut.getSlideCount()
        
        XCTAssertEqual(slideArray.count, count)
    }
    
    func testSlideManagerCanAddSlide() throws {
        let sut = SlideManager()
        sut.slideArray = [sut.squareSlideFactory.getRandomSlide(),
                          sut.squareSlideFactory.getRandomSlide(),
                          sut.squareSlideFactory.getRandomSlide(),
                          sut.squareSlideFactory.getRandomSlide()]
        
        let beforeCount = sut.getSlideCount()
        sut.addSlide()
        let afterCount = sut.getSlideCount()
        
        XCTAssertEqual(beforeCount+1, afterCount)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
