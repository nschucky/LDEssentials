//
//  FeedViewControllerTests.swift
//  LDEssentialsiOSTests
//
//  Created by Antonio Alves on 2/6/21.
//

import XCTest
import UIKit

final class FeedViewController: UIViewController {
    
    var loader: FeedViewControllerTests.LoaderSpy!
    
    convenience init?(loader: FeedViewControllerTests.LoaderSpy) {
        self.init()
        self.loader = loader
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loader.load()
    }
    
}

class FeedViewControllerTests: XCTestCase {
    
    func test_init_doesNotLoadFeed() {
        let sut = makeSUT()
        XCTAssertEqual(sut.loader.loadAllCount, 0)
    }
    
    func test_viewDidLoad_loadsFeed() {
        let sut = makeSUT()
        
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(sut.loader.loadAllCount, 1)
    }
    
    private func makeSUT() -> FeedViewController {
        let loader = LoaderSpy()
        let sut = FeedViewController(loader: loader)
        return sut!
    }
    
    class LoaderSpy {
        private(set) var loadAllCount: Int = 0
        
        func load() {
            loadAllCount += 1
        }
    }
}

