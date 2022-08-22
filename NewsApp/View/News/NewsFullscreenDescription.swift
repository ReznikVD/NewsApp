//
//  NewsFullscreenDescription.swift
//  NewsApp
//
//  Created by Владислав Резник on 19.08.2022.
//

import UIKit

class NewsFullscreenDescription: BaseNewsCell {
    
    // MARK: - Subviews
    
    private lazy var descriptionLabel: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var author: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .heavy)
        label.textColor = .black
        return label
    }()
    
    // MARK: - Properties
    
    override var article: ArticleResult! {
        
        didSet {
            self.descriptionLabel.text = article.summary
            self.publishedTimeLabel.text = article.published_date
            self.author.text = article.author
        }
    }
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        let verticalStackView = UIStackView(arrangedSubviews: [
            descriptionLabel,
            UIStackView(arrangedSubviews: [
                author,
                UILabel(text: "•", font: .systemFont(ofSize: 14, weight: .light)),
                publishedTimeLabel
                ], customSpacing: 16)
            ], customSpacing: 16)
        
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .center
        
        addSubview(verticalStackView)
        
        verticalStackView.fillSuperview(padding: .init(top: 0, left: 30, bottom: 0, right: 30))
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
