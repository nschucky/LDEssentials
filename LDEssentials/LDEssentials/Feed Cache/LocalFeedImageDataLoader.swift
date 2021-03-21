//
//  LocalFeedImageDataLoader.swift
//  LDEssentials
//
//  Created by Antonio Alves on 3/20/21.
//

import Foundation

public protocol FeedImageDataLoaderService {
    func loadImageData(from url: URL) throws -> Data
}


public final class LocalFeedImageDataLoader {
    private let store: FeedImageDataStore
    
    public init(store: FeedImageDataStore) {
        self.store = store
    }
}

extension LocalFeedImageDataLoader: FeedImageDataCache {
    public enum SaveError: Error {
        case failed
    }
    
    public func save(_ data: Data, for url: URL) throws {
        do {
            try store.insert(data, for: url)
        } catch {
            throw SaveError.failed
        }
    }
}

extension LocalFeedImageDataLoader: FeedImageDataLoaderService {
    public enum LoadError: Error {
        case failed
        case notFound
    }
        
    public func loadImageData(from url: URL) throws -> Data {
        do {
            if let imageData = try store.retrieve(dataForURL: url) {
                return imageData
            }
        } catch {
            throw LoadError.failed
        }
        
        throw LoadError.notFound
    }
}
