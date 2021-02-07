//
//  FeedViewController.swift
//  LDEssentialsiOS
//
//  Created by Antonio Alves on 2/6/21.
//

import UIKit
import LDEssentials

final public class FeedViewController: UITableViewController {
    
    var loader: FeedLoader?
    
    public convenience init(loader: FeedLoader) {
        self.init()
        self.loader = loader
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(load), for: .valueChanged)
        load()
    }
    
    @objc private func load() {
        refreshControl?.beginRefreshing()
        loader?.load { [weak self] _ in
            self?.refreshControl?.endRefreshing()
        }
    }
    
}

extension FeedViewController {
    public func simulateUserInitiatedFeedLoad() {
        refreshControl?.simulatePullToRefresh()
    }
    
    public var isShowingLoadingIndicator: Bool {
        return refreshControl?.isRefreshing == true
    }
}

extension UIRefreshControl {
    func simulatePullToRefresh() {
        allTargets.forEach { target in
            actions(forTarget: target, forControlEvent: .valueChanged)?.forEach { (target as NSObject).perform(Selector($0)) }
        }
    }
}

