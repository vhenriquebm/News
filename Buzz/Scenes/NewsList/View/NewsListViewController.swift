//
//  NewsListViewController.swift
//  Buzz
//
//  Created by Vitor Henrique Barreiro Marinho on 18/10/24.
//

import UIKit

protocol NewsListDisplayLogic: AnyObject {
    func displayFetchedNews(viewModel: NewsListModel.FetchNews.ViewModel)
    func displayError(message: String)
}

class NewsListViewController: UIViewController {
    var interactor: NewsListBusinessLogic?
    var router: NewsListRoutingLogic?
    var articles: [NewsListModel.FetchNews.ViewModel.DisplayedArticle] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsListArticleCell.self, forCellReuseIdentifier: NewsListArticleCell.identifier)
        
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        fetchNews()
        setupView()
    }
    
    private func setupView() {
        addSubViews()
        setupConstraints()
    }
    
    private func addSubViews() {
        self.view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func fetchNews() {
        self.interactor?.loadNews(request: NewsListModel.FetchNews.Request())
    }
    
    private func setup() {
        let viewController = self
        let interactor = NewsListInteractor()
        let presenter = NewsListPresenter()
        router = NewsListRouter()
        
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        router?.viewController = viewController
    }
}

extension NewsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let article = articles[indexPath.row]
      
        router?.routeToNewsDetails(articleId: article.id)
    }
}

extension NewsListViewController: UITableViewDataSource {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: NewsListArticleCell.identifier, for: indexPath) as! NewsListArticleCell
        
        cell.configure(with: articles[indexPath.row])
        
        return cell
    }
}

extension NewsListViewController: NewsListDisplayLogic {
    
    func displayFetchedNews(viewModel: NewsListModel.FetchNews.ViewModel) {
        self.articles = viewModel.displayedArticles
        tableView.reloadData()
    }
    
    func displayError(message: String) {
        let alert = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
}
