//
//  NewsFullscreenHeader.swift
//  NewsApp
//
//  Created by Владислав Резник on 19.08.2022.
//

import UIKit

class NewsFullscreenHeader: BaseNewsCell {
    
    // MARK: - Properties
    
    override var article: ArticleResult! {
        
        didSet {
            self.imageView.sd_setImage(with: URL(string: article.media ?? ""))
        }
    }
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        let imageContainer = UIView()
        imageContainer.addSubview(imageView)
        imageView.centerInSuperview(size: .init(width: 280, height: 280))
        
        addSubview(imageContainer)
      
        imageContainer.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 50, left: 30, bottom: 24, right: 30), size: .init(width: 0, height: 300))
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
