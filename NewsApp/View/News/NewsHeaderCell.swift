//
//  NewsHeaderCell.swift
//  NewsApp
//
//  Created by Владислав Резник on 16.08.2022.
//

import UIKit

class NewsHeaderCell: BaseNewsCell {
    
    // MARK: - Properties
    
    override var article: ArticleResult! {
        
        didSet {
            self.titleLabel.text = article.title
            self.publishedTimeLabel.text = whenPublished(date: article.published_date ?? "")
            self.topicLabel.text = article.topic
            self.imageView.sd_setImage(with: URL(string: article.media ?? ""))
        }
    }
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        titleLabel.numberOfLines = 2
        
        imageView.constrainHeight(constant: 132)
        imageView.backgroundColor = .blue
        
        let verticalStackView = UIStackView(arrangedSubviews: [
            imageView,
            titleLabel,
            UIStackView(arrangedSubviews: [
                publishedTimeLabel,
                UILabel(text: "•", font: .systemFont(ofSize: 14, weight: .light)),
                topicLabel
                ], customSpacing: 15),
            ], customSpacing: 18)
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .leading
        
        addSubview(verticalStackView)
        verticalStackView.fillSuperview(padding: .init(top: 16, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
