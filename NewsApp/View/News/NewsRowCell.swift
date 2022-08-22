//
//  NewsRowCell.swift
//  NewsApp
//
//  Created by Владислав Резник on 16.08.2022.
//

import UIKit

class NewsRowCell: BaseNewsCell {
    
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
        
        imageView.constrainWidth(constant: 83)
        imageView.constrainHeight(constant: 83)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        let verticalStackView = UIStackView(arrangedSubviews: [
            titleLabel,
            UIStackView(arrangedSubviews: [
                publishedTimeLabel,
                UILabel(text: "•", font: .systemFont(ofSize: 14, weight: .light)),
                topicLabel
                ], customSpacing: 15)
            ], customSpacing: 18)
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .leading
        
        let stackView = UIStackView(arrangedSubviews: [
            verticalStackView,
            imageView
            ], customSpacing: 16)
        
        stackView.alignment = .center
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 0, left: 27, bottom: 0, right: 27))
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
