//
//  LocalFeedLoader.swift
//  EssentialFeed
//
//  Created by Antonio Alves on 12/30/20.
//

import Foundation

public class LocalFeedLoader: FeedLoader {
    
    private let store: FeedStore
    private let currentDate: () -> Date

    public init(store: FeedStore, currentDate: @escaping () -> Date) {
        self.store = store
        self.currentDate = currentDate
    }
    
    public func load(completion: @escaping (FeedLoader.Result) -> Void) {
        guard let cachedFeed = try? store.retrieve() else {
            completion(.failure(NSError(domain: "Unable to retrieve from store", code: 2919, userInfo: nil)))
            return
        }
        
        guard !cachedFeed.feed.isEmpty, FeedCachePolicy.validate(cachedFeed.timestamp, against: self.currentDate()) else {
            completion(.failure(NSError(domain: "Empty or invalid feed", code: 2920, userInfo: nil)))
            return
        }
        
        completion(.success(cachedFeed.feed.toModels()))
    }
}

extension LocalFeedLoader {
    
    public typealias SaveResult = Error?
    
    public func save(_ feed: [FeedImage]) throws {
        try store.deleteCachedFeed()
        try store.insert(feed.toLocal(), timestamp: currentDate())
    }
}

extension LocalFeedLoader {
    
    private struct InvalidCache: Error {}
    
    public func validateCache() throws {
        do {
            if let cache = try store.retrieve(), !FeedCachePolicy.validate(cache.timestamp, against: currentDate()) {
                throw InvalidCache()
            }
                
        } catch {
            try store.deleteCachedFeed()
        }
    }
}

private extension Array where Element == FeedImage {
    func toLocal() -> [LocalFeedImage] {
        return map { LocalFeedImage(feedId: $0.feedId, description: $0.description, location: $0.location, url: $0.url) }
    }
}

private extension Array where Element == LocalFeedImage {
    func toModels() -> [FeedImage] {
        return map { FeedImage(feedId: $0.feedId, description: $0.description, location: $0.location, url: $0.url) }
    }
}
