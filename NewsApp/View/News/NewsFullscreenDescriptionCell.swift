//
//  NewsFullscreenDescriptionCell.swift
//  NewsApp
//
//  Created by Владислав Резник on 19.08.2022.
//

import UIKit

class NewsFullscreenDescriptionCell: UITableViewCell {
    
    // MARK: - Subviews
    
    var newsFullscreenDescription = NewsFullscreenDescription()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
//        if let newsFullscreenDescription = newsFullscreenDescription {
            
            addSubview(newsFullscreenDescription)
            newsFullscreenDescription.fillSuperview()
   
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
