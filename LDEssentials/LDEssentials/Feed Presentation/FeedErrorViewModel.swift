//
//  FeedErrorViewModel.swift
//  LDEssentials
//
//  Created by Antonio Alves on 3/5/21.
//

import Foundation

public protocol FeedErrorView {
    func display(_ viewModel: FeedErrorViewModel)
}

public struct FeedErrorViewModel {
     public let message: String?

     static var noError: FeedErrorViewModel {
         return FeedErrorViewModel(message: nil)
     }
    
    static func error(message: String) -> FeedErrorViewModel {
        return FeedErrorViewModel(message: message)
    }
}
