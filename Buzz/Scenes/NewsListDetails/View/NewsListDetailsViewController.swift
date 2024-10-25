//
//  NewsListDetailsViewController.swift
//  Buzz
//
//  Created by Vitor Henrique Barreiro Marinho on 24/10/24.
//

import UIKit

protocol NewsListDetailsDisplayLogic: AnyObject {
    func displayFetchedNews(viewModel: NewsListDetailModel.FetchNewsDetail.ViewModel)
    func displayError(message: String)
}

class NewsListDetailsViewController: UIViewController {
    var articleId: Int
    var interactor: NewsListDetailsBusinessLogic?
    
    init(articleId: Int) {
        self.articleId = articleId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNewsById()
        setup()
    }
    
    func fetchNewsById() {
        interactor?.loadNewsFromId(request: NewsListDetailModel.FetchNewsDetail.Request(id: articleId))
    }
    
    private func setup() {
        let viewController = self
        let presenter = NewsListDetailsPresenter()
        let interactor = NewsListDetailInteractor(presenter: presenter)
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
}

extension NewsListDetailsViewController: NewsListDetailsDisplayLogic {
    func displayFetchedNews(viewModel: NewsListDetailModel.FetchNewsDetail.ViewModel) {
        
    }
    
    func displayError(message: String) {
        
    }
}
