//
//  NewsPageHeader.swift
//  NewsApp
//
//  Created by Владислав Резник on 16.08.2022.
//

import UIKit

class NewsPageHeader: UICollectionReusableView {
    
    // MARK: - Subviews
    
    let newsHeaderHorizontalController = NewsHeaderHorizontalContoller()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(newsHeaderHorizontalController.view)
        newsHeaderHorizontalController.view.fillSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
