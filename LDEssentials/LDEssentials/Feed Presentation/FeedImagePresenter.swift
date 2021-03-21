//
//  FeedImagePresenter.swift
//  LDEssentialsiOS
//
//  Created by Antonio Alves on 2/18/21.
//

import Foundation

public protocol FeedImageView {
    associatedtype Image
    
    func display(_ model: FeedImageViewModel<Image>)
}

public final class FeedImagePresenter<View: FeedImageView, Image> where View.Image == Image {
    
    private let view: View
    private let imageTransformer: (Data) -> Image?
    
    public init(view: View, imageTransformer: @escaping (Data) -> Image?) {
        self.view = view
        self.imageTransformer = imageTransformer
    }
    
    public func didStartLoadingImageData(for model: FeedImage) {
        let viewModel = FeedImageViewModel<Image>(description: model.description, location: model.location, image: nil, isLoading: true, shouldRetry: false)
        view.display(viewModel)
    }
    
    private struct InvalidImageDataError: Error {}
    
    public func didFinishLoadingImageData(with data: Data, for model: FeedImage) {
        guard let image = imageTransformer(data) else {
            return didFinishLoadingImageData(with: InvalidImageDataError(), for: model)
        }
        
        let viewModel = FeedImageViewModel<Image>(description: model.description, location: model.location, image: image, isLoading: false, shouldRetry: false)
        view.display(viewModel)
    }
    
    public func didFinishLoadingImageData(with error: Error, for model: FeedImage) {
        let viewModel = FeedImageViewModel<Image>(description: model.description, location: model.location, image: nil, isLoading: false, shouldRetry: true)
        view.display(viewModel)
    }
    
    
}
