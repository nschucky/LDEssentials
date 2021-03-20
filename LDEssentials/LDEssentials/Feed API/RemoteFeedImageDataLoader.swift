//
//  RemoteFeedImageDataLoader.swift
//  LDEssentials
//
//  Created by Antonio Alves on 3/20/21.
//

import Foundation

//public final class RemoteFeedImageDataLoader: FeedImageDataLoader {
//
//    private let client: HTTPClient
//
//    init(client: HTTPClient) {
//        self.client = client
//    }
//
//    public enum Error: Swift.Error {
//        case connectivity
//        case invalidData
//    }
//
//    public func loadImageData(from url: URL, completion: @escaping (FeedImageDataLoader.Result) -> Void) -> FeedImageDataLoaderTask {
//        let task = HTTPClientTaskWrapper(completion)
//        task.wrapped = client.get(from: url) { [weak self] (result) in
//            guard let self = self else { return }
//            task.complete(with: result
//                            .mapError { _ in Error.connectivity}
//                            .flatMap { (data, response) in
//                                let isValidResponse = response.isOK && !data.isEmpty
//                                return s=isValidResponse ? .success(data) : .failure(Error.invalidData)
//                            })
//            return task
//        }
//    }
//
//
//}
