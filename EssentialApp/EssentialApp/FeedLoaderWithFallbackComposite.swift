//
//  FeedLoaderWithFallbackComposite.swift
//  EssentialApp
//
//  Created by Antonio Alves on 4/2/21.
//

import Foundation
import LDEssentials

public class FeedLoaderWithFallbackComposite: FeedLoader {
    
    private let primary: FeedLoader
    private let fallback: FeedLoader
    
    public init(primary: FeedLoader, fallback: FeedLoader) {
        self.primary = primary
        self.fallback = fallback
    }
    
    public func load(completion: @escaping (FeedLoader.Result) -> Void) {
        primary.load { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure:
                self.fallback.load(completion: completion)
            case .success:
                completion(result)
            }
        }
    }
}
