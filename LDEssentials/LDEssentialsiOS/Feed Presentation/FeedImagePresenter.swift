//
//  FeedImagePresenter.swift
//  LDEssentialsiOS
//
//  Created by Antonio Alves on 2/18/21.
//

import Foundation
import LDEssentials

protocol FeedImageView {
    associatedtype Image
    
    func display(_ model: FeedImageViewModel<Image>)
}

final class FeedImagePresenter<View: FeedImageView, Image> where View.Image == Image {
    
    private let view: View
    private let imageTransformer: (Data) -> Image?
    
    init(view: View, imageTransformer: @escaping (Data) -> Image?) {
        self.view = view
        self.imageTransformer = imageTransformer
    }
    
    func didStartLoadingImageData(for model: FeedImage) {
        let viewModel = FeedImageViewModel<Image>(description: model.description, location: model.location, image: nil, isLoading: true, shouldRetry: false)
        view.display(viewModel)
    }
    
    private struct InvalidImageDataError: Error {}
    
    func didFinishLoadingImageData(with data: Data, for model: FeedImage) {
        guard let image = imageTransformer(data) else {
            return didFinishLoadingImageData(with: InvalidImageDataError(), for: model)
        }
        
        let viewModel = FeedImageViewModel<Image>(description: model.description, location: model.location, image: image, isLoading: false, shouldRetry: false)
        view.display(viewModel)
    }
    
    func didFinishLoadingImageData(with error: Error, for model: FeedImage) {
        let viewModel = FeedImageViewModel<Image>(description: model.description, location: model.location, image: nil, isLoading: false, shouldRetry: true)
        view.display(viewModel)
    }
    
    
}