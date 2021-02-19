//
//  FeedImageViewModel.swift
//  LDEssentialsiOS
//
//  Created by Antonio Alves on 2/13/21.
//

import Foundation

struct FeedImageViewModel<Image> {
    let description: String?
    let location: String?
    let image: Image?
    let isLoading: Bool
    let shouldRetry: Bool
    
    var hasLocation: Bool {
        return location != nil
    }
}
