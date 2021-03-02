//
//  MainQueueDispatchDecorator.swift
//  LDEssentialsiOS
//
//  Created by Antonio Alves on 3/1/21.
//

import Foundation
import LDEssentials

final class MainQueueDispatchDecorator<T> {
    private let decoratee: T
    
    init(decoratee: T) {
        self.decoratee = decoratee
    }
    
    private func dispatch(_ completion: @escaping () -> ()) {
        guard Thread.isMainThread else { return DispatchQueue.main.async(execute: completion) }
        completion()
    }
}
extension MainQueueDispatchDecorator: FeedLoader where T == FeedLoader {
    
    func load(completion: @escaping (FeedLoader.Result) -> Void) {
        decoratee.load { [weak self] (result) in
            guard let self = self else { return }
            self.dispatch { completion(result) }
        }
    }
}

extension MainQueueDispatchDecorator: FeedImageDataLoader where T == FeedImageDataLoader {
    
    func loadImageData(from url: URL, completion: @escaping (FeedImageDataLoader.Result) -> Void) -> FeedImageDataLoaderTask {
        return decoratee.loadImageData(from: url) { [weak self] (result) in
            guard let self = self else { return }
            self.dispatch { completion(result) }
        }
    }
    
    
}
