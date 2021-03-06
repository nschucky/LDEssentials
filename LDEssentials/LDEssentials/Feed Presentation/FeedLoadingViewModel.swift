//
//  FeedLoadingViewModel.swift
//  LDEssentials
//
//  Created by Antonio Alves on 3/5/21.
//

import Foundation

public protocol FeedLoadingView {
    func display(_ viewModel: FeedLoadingViewModel)
}

public struct FeedLoadingViewModel {
    public let isLoading: Bool
}
