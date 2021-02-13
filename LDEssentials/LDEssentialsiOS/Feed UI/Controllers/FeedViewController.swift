//
//  FeedViewController.swift
//  LDEssentialsiOS
//
//  Created by Antonio Alves on 2/6/21.
//

import UIKit
import LDEssentials

final public class FeedViewController: UITableViewController, UITableViewDataSourcePrefetching {
    
    private var feedRefreshController: FeedRefreshViewController?

    var tableModel: [FeedImageCellController] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    convenience init(refreshController: FeedRefreshViewController) {
        self.init()
        self.feedRefreshController = refreshController
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = feedRefreshController?.view
        
        tableView.prefetchDataSource = self
        feedRefreshController?.refresh()
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableModel.count
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellController(forRowAt: indexPath).view()
    }
    
    public override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cancelCellControllerLoad(forRowAt: indexPath)
    }
    
    
    
    public func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { index in
            cellController(forRowAt: index).preload()
        }
    }
    
    public func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach(cancelCellControllerLoad)
    }
    
    private func cancelCellControllerLoad(forRowAt indexPath: IndexPath) {
        tableModel[indexPath.row].cancelLoad()
    }
    
    private func cellController(forRowAt indexPath: IndexPath) -> FeedImageCellController {
        return tableModel[indexPath.row]
    }
    
}
