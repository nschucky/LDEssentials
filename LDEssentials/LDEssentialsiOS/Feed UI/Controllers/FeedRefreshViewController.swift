//
//  FeedRefreshViewController.swift
//  LDEssentialsiOS
//
//  Created by Antonio Alves on 2/12/21.
//

import UIKit

public final class FeedRefreshViewController: NSObject, FeedLoadingView {
    
    private(set) lazy var view: UIRefreshControl = loadView()
    
    private let feedPresenter: FeedPresenter
    
    init(feedPresenter: FeedPresenter) {
        self.feedPresenter = feedPresenter
    }
    
    @objc func refresh() {
        feedPresenter.loadFeed()
    }
    
    private func loadView() -> UIRefreshControl {
        let view = UIRefreshControl()
        view.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return view
    }
    
    func display(isLoading: Bool) {
        if isLoading {
            view.beginRefreshing()
        } else {
            view.endRefreshing()
        }
    }
}
