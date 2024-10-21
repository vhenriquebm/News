//
//  NewsListViewController.swift
//  Buzz
//
//  Created by Vitor Henrique Barreiro Marinho on 18/10/24.
//

import UIKit

class NewsListViewController: UIViewController {
    private let interactor = NewsListInteractor()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactor.loadNews(request: NewsListModel.FetchNews.Request())
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
}

extension NewsListViewController: UITableViewDelegate {
    
}

extension NewsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = "Noticia"
        cell.contentConfiguration = content
        return cell
    }
}
