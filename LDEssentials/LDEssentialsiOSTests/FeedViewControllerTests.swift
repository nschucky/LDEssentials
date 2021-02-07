//
//  FeedViewControllerTests.swift
//  LDEssentialsiOSTests
//
//  Created by Antonio Alves on 2/6/21.
//

import XCTest
import UIKit
import LDEssentials
import LDEssentialsiOS

class FeedViewControllerTests: XCTestCase {
    
    func test_loadFeedActions_requestFeedFromLoader() {
        
        let (sut, loader) = makeSUT()
        XCTAssertEqual(loader.loadAllCount, 0)
        
        sut.loadViewIfNeeded()
        XCTAssertEqual(loader.loadAllCount, 1)
        
        sut.simulateUserInitiatedFeedLoad()
        XCTAssertEqual(loader.loadAllCount, 2)
        
        sut.simulateUserInitiatedFeedLoad()
        XCTAssertEqual(loader.loadAllCount, 3)
    }
    
    func test_loadingFeedIndicator_isVisibleWhileLoading() {
        let (sut, loader) = makeSUT()
        
        sut.loadViewIfNeeded()
        XCTAssertTrue(sut.isShowingLoadingIndicator)
        
        loader.completeFeedLoading()
        XCTAssertFalse(sut.isShowingLoadingIndicator)
        
        sut.simulateUserInitiatedFeedLoad()
        XCTAssertTrue(sut.isShowingLoadingIndicator)
        
        loader.completeFeedLoading(at: 1)
        XCTAssertFalse(sut.isShowingLoadingIndicator)
    }
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: FeedViewController, loader: LoaderSpy) {
        let loader = LoaderSpy()
        let sut = FeedViewController(loader: loader)
        trackForMemoryLeaks(loader, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut, loader)
    }
    
    class LoaderSpy: FeedLoader {
        
        var loadAllCount: Int {
            return completions.count
        }
        private var completions: [(FeedLoader.Result) -> Void] = []
        
        func load(completion: @escaping (FeedLoader.Result) -> Void) {
            completions.append(completion)
        }
        
        func completeFeedLoading(at index: Int = 0) {
            completions[index](.success([]))
        }
    }
}
