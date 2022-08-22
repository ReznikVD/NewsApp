//
//  NewsFullscreenCell.swift
//  NewsApp
//
//  Created by Владислав Резник on 18.08.2022.
//

import UIKit

class NewsFullscreenHeaderCell: UITableViewCell {
    
    // MARK: - Subviews
    
    lazy var newsFullscreenHeader = NewsFullscreenHeader()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(newsFullscreenHeader)
        newsFullscreenHeader.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
}
