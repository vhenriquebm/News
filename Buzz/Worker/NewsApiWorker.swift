//
//  NewsApiWorker.swift
//  Buzz
//
//  Created by Vitor Henrique Barreiro Marinho on 21/10/24.
//

import Foundation

enum NewsAPI {
    static let baseUrl = "https://my-json-server.typicode.com/alura-cursos/news-api/"
    static let articles = "articles"
}

class NewsApiWorker {
    private let service: NetworkingService
    
    init(service: NetworkingService) {
        self.service = service
    }
    
    func fetchNews(completion: @escaping (Result<[Article], Error>) -> Void ) {
        
        guard let url = URL(string: NewsAPI.baseUrl + NewsAPI.articles) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        service.request(url: url) { (result: Result<[Article], Error>) in
            
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
