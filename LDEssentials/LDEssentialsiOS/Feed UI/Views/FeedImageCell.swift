//
//  FeedImageCell.swift
//  LDEssentialsiOS
//
//  Created by Antonio Alves on 2/11/21.
//

import UIKit

public final class FeedImageCell: UITableViewCell {
    
    var onRetry: (() -> Void)?
    
    public var locationContainer = UIView()
    public var locationLabel = UILabel()
    public var descriptionLabel = UILabel()
    public var feedImageContainer = UIView()
    public var feedImageView = UIImageView()
    
    private(set) public lazy var feedImageRetryButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(retryButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc private func retryButtonTapped() {
        onRetry?()
    }
    
}
