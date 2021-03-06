//
//  FeedErrorViewModel.swift
//  LDEssentialsiOS
//
//  Created by Antonio Alves on 3/4/21.
//

import Foundation

protocol FeedErrorView {
    func display(_ viewModel: FeedErrorViewModel)
}


struct FeedErrorViewModel {
     let message: String?

     static var noError: FeedErrorViewModel {
         return FeedErrorViewModel(message: nil)
     }
    
    static func error(message: String) -> FeedErrorViewModel {
        return FeedErrorViewModel(message: message)
    }
 }

