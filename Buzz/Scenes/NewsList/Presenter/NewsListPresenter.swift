//
//  NewsListPresenter.swift
//  Buzz
//
//  Created by Vitor Henrique Barreiro Marinho on 21/10/24.
//

import Foundation

protocol NewsListPresentationLogic {
    func presentFetchedNews(response: NewsListModel.FetchNews.Response)
    func presentError(error: Error)
}

class NewsListPresenter: NewsListPresentationLogic {
    weak var viewController: NewsListDisplayLogic?
    
    func presentFetchedNews(response: NewsListModel.FetchNews.Response) {
        let displayedArticles = response.articles.map { article in
            return NewsListModel.FetchNews.ViewModel.DisplayedArticle(
                id: article.id, 
                title: article.title,
                description: article.description,
                author: article.author,
                publishedAt: article.publishedAt.formatDate(),
                imageUrl: article.urlToImage)
        }
        
        let viewModel = NewsListModel.FetchNews.ViewModel(displayedArticles: displayedArticles)
        
        viewController?.displayFetchedNews(viewModel: viewModel)
    }
    
    func presentError(error: any Error) {
        viewController?.displayError(message: error.localizedDescription)
    }
}
