//
//  NewsDetailContoller.swift
//  NewsApp
//
//  Created by Владислав Резник on 18.08.2022.
//

import UIKit

class NewsFullscreenContoller: UIViewController {
    
    // MARK: - Subviews
    
    lazy var tableView = UITableView(frame: .zero, style: .plain)
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "cancel_button"), for: . normal)
        return button
    }()
    
    // MARK: - Properties
    
    var article: ArticleResult?
    var dismissHandler: (() -> ())?
    let statusBarHeight = UIApplication.shared.connectedScenes
            .filter {$0.activationState == .foregroundActive }
            .map {$0 as? UIWindowScene }
            .compactMap { $0 }
            .first?.windows
            .filter({ $0.isKeyWindow }).first?
            .windowScene?.statusBarManager?.statusBarFrame.height ?? 0
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.clipsToBounds = true
        view.addSubview(tableView)
        
        tableView.fillSuperview()
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.contentInset = .init(top: 0, left: 0, bottom: statusBarHeight, right: 0)
        
        setupCancelButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.superview?.setNeedsLayout()
    }
    
    // MARK: - Methods
    
    fileprivate func setupCancelButton() {
        view.addSubview(closeButton)
        closeButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 12, left: 0, bottom: 0, right: 0), size: .init(width: 80, height: 40))
        closeButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
    }
    
    @objc fileprivate func handleDismiss(sender: UIButton) {
        sender.isHidden = true
        dismissHandler?()
    }
}

// MARK: - UITableViewDataSource

extension NewsFullscreenContoller: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let headerCell = NewsFullscreenHeaderCell()
            headerCell.newsFullscreenHeader.article = self.article
            headerCell.newsFullscreenHeader.backgroundView = nil
            return headerCell
        }
        let descriptionCell = NewsFullscreenDescriptionCell()
        descriptionCell.newsFullscreenDescription.article = self.article
        return descriptionCell
        
    }
}


