//
//  NewsFullscreenHeader.swift
//  NewsApp
//
//  Created by Владислав Резник on 19.08.2022.
//

import UIKit

class NewsFullscreenHeader: BaseNewsCell {
    
    // MARK: - Properties
    
    override var article: NewsResult! {
        didSet {
            self.titleLabel.text = article.title
            self.imageView.sd_setImage(with: URL(string: article.media ?? ""))
        }
    }
    
    static let cellSize: CGFloat = 450
    var topConstraint: NSLayoutConstraint!
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.numberOfLines = 3
        titleLabel.font = .boldSystemFont(ofSize: 20)
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        let imageContainerView = UIView()
        imageContainerView.addSubview(imageView)
        imageView.centerInSuperview(size: .init(width: 240, height: 240))
        
        let verticalStackView = UIStackView(arrangedSubviews: [
            titleLabel,
            imageContainerView,
            ], customSpacing: 8)
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .center
        
        addSubview(verticalStackView)
        verticalStackView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 27, bottom: 24, right: 27))
        self.topConstraint = verticalStackView.topAnchor.constraint(equalTo: topAnchor, constant: 24)
        self.topConstraint.isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
