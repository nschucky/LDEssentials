//
//  FeedViewControllerTests.swift
//  LDEssentialsiOSTests
//
//  Created by Antonio Alves on 2/6/21.
//

import XCTest
import UIKit
import LDEssentials

final class FeedViewController: UIViewController {
    
    var loader: FeedLoader?
    
    convenience init?(loader: FeedLoader) {
        self.init()
        self.loader = loader
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loader?.load { _ in }
    }
    
}

class FeedViewControllerTests: XCTestCase {
    
    func test_init_doesNotLoadFeed() {
        let (sut, loader) = makeSUT()
        XCTAssertEqual(loader.loadAllCount, 0)
    }
    
    func test_viewDidLoad_loadsFeed() {
        let (sut, loader) = makeSUT()
        
        sut.loadViewIfNeeded()
        
        XCTAssertEqual(loader.loadAllCount, 1)
    }
    
    private func makeSUT() -> (sut: FeedViewController, loader: LoaderSpy) {
        let loader = LoaderSpy()
        let sut = FeedViewController(loader: loader)
        return (sut!, loader)
    }
    
    class LoaderSpy: FeedLoader {
        
        private(set) var loadAllCount: Int = 0
        
        func load(completion: @escaping (FeedLoader.Result) -> Void) {
            loadAllCount += 1
        }
    }
}

