//
//  NewsFullscreenDescription.swift
//  NewsApp
//
//  Created by Владислав Резник on 19.08.2022.
//

import UIKit

class NewsFullscreenDescription: BaseNewsCell {
    
    // MARK: - Subviews
    
    var descriptionLabel = UILabel(text: "Some text", font: .systemFont(ofSize: 14))
    
    // MARK: - Properties
    
    override var article: NewsResult! {
        didSet {
            self.descriptionLabel.text = article.summary
        }
    }
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
