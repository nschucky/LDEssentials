//
//  FeedImageDataStore.swift
//  LDEssentials
//
//  Created by Antonio Alves on 3/20/21.
//

import Foundation

public protocol FeedImageDataStore {
    func insert(_ data: Data, for url: URL) throws
    func retrieve(dataForURL url: URL) throws -> Data?
}
