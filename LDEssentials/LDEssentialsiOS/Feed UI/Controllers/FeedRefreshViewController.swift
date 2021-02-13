//
//  FeedRefreshViewController.swift
//  LDEssentialsiOS
//
//  Created by Antonio Alves on 2/12/21.
//

import UIKit

public final class FeedRefreshViewController: NSObject {
    
    private(set) lazy var view: UIRefreshControl = binded(UIRefreshControl())
    
    let feedViewModel: FeedViewModel
    
    init(feedViewModel: FeedViewModel) {
        self.feedViewModel = feedViewModel
    }
    
    @objc func refresh() {
        feedViewModel.loadFeed()
    }
    
    private func binded(_ view: UIRefreshControl) -> UIRefreshControl {
        feedViewModel.onChange = { [weak self] viewModel in
            if viewModel.isLoading {
                self?.view.beginRefreshing()
            } else {
                self?.view.endRefreshing()
            }
            
        }
        view.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return view
    }
}
