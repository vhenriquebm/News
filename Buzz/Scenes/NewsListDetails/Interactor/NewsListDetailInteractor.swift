//
//  NewsListDetailInteractor.swift
//  Buzz
//
//  Created by Vitor Henrique Barreiro Marinho on 24/10/24.
//

import Foundation

protocol NewsListDetailsBusinessLogic {
    func loadNewsFromId(request: NewsListDetailModel.FetchNewsDetail.Request)
}

protocol NewsListDetailsDataStore {
    var article: Article? { get set }
}

class NewsListDetailInteractor: NewsListDetailsBusinessLogic, NewsListDetailsDataStore {
    private var worker: NewsApiWorker
    var presenter: NewsListDetailsPresentationLogic
    var article: Article?
    
    init(worker: NewsApiWorker = NewsApiWorker(service: URLSessionNetworking()), presenter: NewsListDetailsPresentationLogic) {
        self.worker = worker
        self.presenter = presenter
    }
    
    func loadNewsFromId(request: NewsListDetailModel.FetchNewsDetail.Request) {
        worker.fetchNewsBy(id: request.id) { [ weak self ] result in
            guard let self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let article):
                    self.article = article
                    let response = NewsListDetailModel.FetchNewsDetail.Response(article: article)
                    self.presenter.presentFetchedNewsById(response: response)
                case .failure(let failure):
                    self.presenter.present(error: failure)
                }
            }
        }
    }
}
