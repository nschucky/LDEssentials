//
//  FeedPresenterTests.swift
//  LDEssentialsTests
//
//  Created by Antonio Alves on 3/3/21.
//

import XCTest

protocol FeedErrorView {
    func display(_ viewModel: FeedErrorViewModel)
}

struct FeedErrorViewModel {
     let message: String?

     static var noError: FeedErrorViewModel {
         return FeedErrorViewModel(message: nil)
     }
}

struct FeedLoadingViewModel {
    let isLoading: Bool
}

protocol FeedLoadingView {
    func display(_ viewModel: FeedLoadingViewModel)
}

final class FeedPresenter {
    
    let loadingView: FeedLoadingView
    let errorView: FeedErrorView
    
    init(loadingView: FeedLoadingView, errorView: FeedErrorView) {
        self.loadingView = loadingView
        self.errorView = errorView
    }
    
    func didStartLoadingFeed() {
        errorView.display(.noError)
        loadingView.display(FeedLoadingViewModel(isLoading: true))
    }
}

class FeedPresenterTests: XCTestCase {
    
    func test_init_doesNotSendMessagesToView() {
        let (_, view) = makeSUT()
        XCTAssertTrue(view.messages.isEmpty, "Expected no view messages")
    }
    
    func test_didStartLoadingFeed_displaysNoErrorMessageAndStartsLoading() {
        let (sut, view) = makeSUT()
        sut.didStartLoadingFeed()
        XCTAssertEqual(view.messages, [
                        .display(errorMessage: nil),
                        .display(isLoading: true)])
    }
    
    // MARK: - Helpers
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: FeedPresenter, view: ViewSpy) {
        let view = ViewSpy()
        let sut = FeedPresenter(loadingView: view, errorView: view)
        trackForMemoryLeaks(view)
        trackForMemoryLeaks(sut)
        return (sut, view)
    }
    
    private class ViewSpy: FeedErrorView, FeedLoadingView {
        
        func display(_ viewModel: FeedLoadingViewModel) {
            messages.insert(.display(isLoading: viewModel.isLoading))
        }
        
        
        func display(_ viewModel: FeedErrorViewModel) {
            messages.insert(.display(errorMessage: nil))
        }
        
        
        enum Message: Hashable {
            case display(errorMessage: String?)
            case display(isLoading: Bool)
        }
        
        private(set) var messages: Set<Message> = []
    }
    
}
