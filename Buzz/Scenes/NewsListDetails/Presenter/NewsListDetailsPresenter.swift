//
//  NewsListDetailsPresenter.swift
//  Buzz
//
//  Created by Vitor Henrique Barreiro Marinho on 24/10/24.
//

import Foundation

protocol NewsListDetailsPresentationLogic {
    func presentFetchedNewsById(response: NewsListDetailModel.FetchNewsDetail.Response)
    func present(error: Error)
}

class NewsListDetailsPresenter: NewsListDetailsPresentationLogic {
    weak var viewController: NewsListDetailsViewController?
    
    func presentFetchedNewsById(response: NewsListDetailModel.FetchNewsDetail.Response) {
        guard let article = response.article else { return }
        
        let displayedArticle = NewsListDetailModel.FetchNewsDetail.ViewModel.DisplayedArticle(
            title: article.title,
            description: article.description,
            author: article.author,
            content: article.content,
            imageUrl: article.urlToImage,
            url: article.url,
            publishedAt: article.publishedAt.formatted())
        
        let viewModel = NewsListDetailModel.FetchNewsDetail.ViewModel(displayedArticle: displayedArticle)
        
        viewController?.displayFetchedNews(viewModel: viewModel)
    }
    
    func present(error: any Error) {
        viewController?.displayError(message: error.localizedDescription)
    }
}
