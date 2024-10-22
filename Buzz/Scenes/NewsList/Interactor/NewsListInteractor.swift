//
//  NewsListInteractor.swift
//  Buzz
//
//  Created by Vitor Henrique Barreiro Marinho on 21/10/24.
//

import Foundation

typealias NewsListInteractorProtocol = NewsListBusinessLogic & NewsListDataStore

protocol NewsListBusinessLogic {
    func loadNews(request: NewsListModel.FetchNews.Request)
}

protocol NewsListDataStore {
    var articles: [Article] { get set }
}

class NewsListInteractor: NewsListInteractorProtocol {
    private var worker: NewsApiWorker
    var presenter: NewsListPresentationLogic?
    var articles = [Article]()
    
    init(worker: NewsApiWorker = NewsApiWorker(service: URLSessionNetworking())) {
        self.worker = worker
    }
    
    func loadNews(request: NewsListModel.FetchNews.Request) {
        worker.fetchNews { [ weak self ] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                
                switch result {
                case .success(let articles):
                    self.articles = articles
                    let response = NewsListModel.FetchNews.Response(articles: articles)
                    self.presenter?.presentFetchedNews(response: response)
                case .failure(let failure):
                    self.presenter?.presentError(error: failure)
                }
            }
        }
    }
}
