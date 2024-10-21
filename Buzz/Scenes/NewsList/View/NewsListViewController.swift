//
//  NewsListViewController.swift
//  Buzz
//
//  Created by Vitor Henrique Barreiro Marinho on 18/10/24.
//

import UIKit

class NewsListViewController: UIViewController {
    private let interactor = NewsListInteractor()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        self.interactor.loadNews(request: NewsListModel.FetchNews.Request())
    }
}
