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
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.color = .black
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        return aiv
    }()
    
    private lazy var titleView: UIStackView = {
        
        let imageView = UIImageView(image: UIImage(named: "Header"))
        let label = UILabel(text: "News", font: .systemFont(ofSize: 16))
        let stackView = UIStackView(arrangedSubviews: [
            imageView, label
            ])
        return stackView
    }()
    
    var newsFullscreenContoller: NewsFullscreenContoller?
    
    // MARK: - Properties
    
    fileprivate let cellId = "cellId"
    fileprivate let headerId = "headerId"
    fileprivate var articles = [ArticleResult]()
    fileprivate var headerArticles = [ArticleResult]()
    fileprivate var startingFrame: CGRect?
    fileprivate var anchoredConstraints: AnchoredConstraints?
    
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
            
        Service.shared.fetchTodayNews { (articles, err) in
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
    
    fileprivate func setupNewsFullscreenController(_ indexPath: IndexPath) {
    
        let fullscreenView = NewsFullscreenContoller()
        fullscreenView.article = articles[indexPath.item]
        fullscreenView.dismissHandler = {
            self.handleNewsFullscreenDismissal()
        }
        fullscreenView.view.layer.cornerRadius = 16
        self.newsFullscreenContoller = fullscreenView
    }
    
    @objc func handleNewsFullscreenDismissal() {
        
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.newsFullscreenContoller?.view.removeFromSuperview()
        self.newsFullscreenContoller?.removeFromParent()
        
        self.collectionView.isUserInteractionEnabled = true
    }
    
    fileprivate func setupNewsFullscreenStartingPosition(_ indexPath: IndexPath) {
        
        guard let newsFullscreenContoller = newsFullscreenContoller else { return }

        guard let fullscreenView = newsFullscreenContoller.view else { return }
    
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.prefersLargeTitles = false
        
        view.addSubview(fullscreenView)
        
        addChild(newsFullscreenContoller)
        
        self.collectionView.isUserInteractionEnabled = false
        
        setupStartingCellFrame(indexPath)
        
        guard let startingFrame = self.startingFrame else { return }
        
        self.anchoredConstraints = fullscreenView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: startingFrame.origin.y, left: startingFrame.origin.x, bottom: 0, right: 0), size: .init(width: startingFrame.width, height: startingFrame.height))
        
        self.view.layoutIfNeeded()
    }
    
    fileprivate func setupStartingCellFrame(_ indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        
        // absolute coordinate of cell
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
        
        self.startingFrame = startingFrame
    }
    
    fileprivate func beginAnimationNewsFullscreen() {
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            self.anchoredConstraints?.top?.constant = 0
            self.anchoredConstraints?.leading?.constant = 0
            self.anchoredConstraints?.width?.constant = self.view.frame.width
            self.anchoredConstraints?.height?.constant = self.view.frame.height
            
            self.view.layoutIfNeeded()
            
            self.tabBarController?.tabBar.frame.origin.y += 100
            
            guard let cell = self.newsFullscreenContoller?.tableView.cellForRow(at: [0, 0]) as? NewsFullscreenHeaderCell else { return }
            cell.newsFullscreenHeader.topConstraint.constant = 50
            cell.layoutIfNeeded()
            
        }, completion: nil)
    }
}

// MARK: - UICollectionViewDelegate

extension NewsPageContoller {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? BaseNewsCell else {
            return UICollectionViewCell()
        }
        
        let article = articles[indexPath.item]
        cell.article = article
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        setupNewsFullscreenController(indexPath)
        setupNewsFullscreenStartingPosition(indexPath)
        beginAnimationNewsFullscreen()
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
