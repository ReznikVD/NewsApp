//
//  NewsSearchController.swift
//  NewsApp
//
//  Created by Владислав Резник on 22.08.2022.
//

import UIKit

class NewsSearchController: BaseListController {
    
    // MARK: - Subviews
    
    fileprivate var searchController = UISearchController(searchResultsController: nil)
    private lazy var enterSearchTermLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Please enter search term above..."
        lbl.textAlignment = .center
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        return lbl
    }()
    
    // MARK: - Properties
    
    var articleResults = [ArticleResult]()
    let cellId = "cellId"
    var timer: Timer?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        collectionView.addSubview(enterSearchTermLabel)
        enterSearchTermLabel.fillSuperview(padding: .init(top: 100, left: 50, bottom: 0, right: 50))
        
        collectionView.register(NewsRowCell.self, forCellWithReuseIdentifier: cellId)
        setupSearchBar()
    }
    
    // MARK: - Methods
    
    fileprivate func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        enterSearchTermLabel.isHidden = articleResults.count != 0
        return articleResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? NewsRowCell else {
            return UICollectionViewCell()
        }
        
        let article = articleResults[indexPath.item]
        cell.article = article
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension NewsSearchController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: self.view.frame.width, height: 100)
    }
}

// MARK: - UISearchBarDelegate

extension NewsSearchController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { _ in
        
            Service.shared.fetchNews(searchTerm: searchText) { article, err in
                
                if let _ = err {
                    return
                }
                
                self.articleResults = article?.articles ?? []
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        })
    }
}
