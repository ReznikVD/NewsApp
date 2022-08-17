//
//  NewsHeaderHorizontalContoller.swift
//  NewsApp
//
//  Created by Владислав Резник on 16.08.2022.
//

import UIKit

class NewsHeaderHorizontalContoller: HorizontalSnappingController {
    
    // MARK: - Properties
    
    let cellId = "cellId"
    var headerArticles = [NewsResult]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(NewsHeaderCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.contentInset = .init(top: 0, left: 27, bottom: 0, right: 27)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return headerArticles.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? NewsHeaderCell else {
            return UICollectionViewCell()
        }
        let article = headerArticles[indexPath.item]
        cell.article = article
        return cell
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension NewsHeaderHorizontalContoller: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 60, height: view.frame.height)
    }
}
