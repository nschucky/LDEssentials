//
//  FeedViewModel.swift
//  LDEssentialsiOS
//
//  Created by Antonio Alves on 2/13/21.
//

import Foundation
import LDEssentials

protocol FeedLoadingView {
    func display(isLoading: Bool)
}

protocol FeedView {
    func display(feed: [FeedImage])
}

final class FeedPresenter {
    
    typealias Observer<T> = (T) -> Void
    private let feedLoader: FeedLoader
    
    init(feedLoader: FeedLoader) {
        self.feedLoader = feedLoader
    }
    
    var feedLoadingView: FeedLoadingView?
    var feedView: FeedView?
    
    func loadFeed() {
        feedLoadingView?.display(isLoading: true)
        feedLoader.load { [weak self] result in
            if let feed = try? result.get() {
                self?.feedView?.display(feed: feed)
            }
            self?.feedLoadingView?.display(isLoading: false)
        }
        
    }
}
