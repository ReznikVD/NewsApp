//
//  NewsPageContoller.swift
//  NewsApp
//
//  Created by Владислав Резник on 16.08.2022.
//

import UIKit
import SDWebImage

class NewsPageContoller: BaseListController {
    
    // MARK: - Subviews
    
    let activityIndicatorView: UIActivityIndicatorView = {
        
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.color = .black
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        return aiv
    }()
    
    let titleView: UIStackView = {
        
        let imageView = UIImageView(image: UIImage(named: "Header"))
        let label = UILabel(text: "News", font: .systemFont(ofSize: 16))
        let stackView = UIStackView(arrangedSubviews: [
            imageView, label
            ])
        return stackView
    }()
    
    // MARK: - Properties
    
    fileprivate let cellId = "CellId"
    fileprivate let headerId = "headerId"
    fileprivate var articles = [NewsResult]()
    fileprivate var headerArticles = [NewsResult]()
    
    // MARK: - Lifecylce
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
       
       
        
        collectionView.register(NewsRowCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(NewsPageHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        collectionView.showsVerticalScrollIndicator = false
        
        view.addSubview(activityIndicatorView)
        activityIndicatorView.fillSuperview()
        
        fetchData()
    }
    
    // MARK: - Methods
    
    fileprivate func fetchData() {
        
        let dispatchGroup = DispatchGroup()

        dispatchGroup.enter()
            
        Service.shared.fetchAllNews { (articles, err) in
            dispatchGroup.leave()
            self.articles = articles?.articles ?? []
        }
        
        dispatchGroup.enter()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            Service.shared.fetchTopNews { articles, err in
                dispatchGroup.leave()
                self.headerArticles = articles?.articles ?? []
            }
        }
            
        dispatchGroup.notify(queue: .main) {
            self.activityIndicatorView.stopAnimating()
            self.collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDelegate

extension NewsPageContoller {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? NewsRowCell else {
            return UICollectionViewCell()
        }
        let article = articles[indexPath.item]
        cell.article = article
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as? NewsPageHeader else {
            return UICollectionReusableView()
        }
        
        header.newsHeaderHorizontalController.headerArticles = self.headerArticles
        header.newsHeaderHorizontalController.collectionView.reloadData()
        return header
    }
}

// MARK: - UICollectionViewDataSource

extension NewsPageContoller {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension NewsPageContoller: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 225)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: self.view.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
}
