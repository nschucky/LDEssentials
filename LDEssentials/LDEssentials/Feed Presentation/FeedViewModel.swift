//
//  FeedViewModel.swift
//  LDEssentials
//
//  Created by Antonio Alves on 3/5/21.
//

import Foundation

public protocol FeedView {
    func display(_ viewModel: FeedViewModel)
}

public struct FeedViewModel {
    public let feed: [FeedImage]
}
