//
//  FeedImageDataCache.swift
//  LDEssentials
//
//  Created by Antonio Alves on 3/20/21.
//

import Foundation

public protocol FeedImageDataCache {
    func save(_ data: Data, for url: URL) throws
}
