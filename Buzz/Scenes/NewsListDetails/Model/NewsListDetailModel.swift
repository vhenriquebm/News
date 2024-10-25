//
//  NewsListDetailViewModel.swift
//  Buzz
//
//  Created by Vitor Henrique Barreiro Marinho on 24/10/24.
//

import Foundation

struct NewsListDetailModel {
    struct FetchNewsDetail {
        
        struct Request {
            let id: Int
        }
        
        struct Response {
            let article: Article?
        }
        
        struct ViewModel {
            struct DisplayedArticle {
                let title: String
                let description: String
                let author: String
                let content: String
                let imageUrl: URL
                let url: URL
                let publishedAt: String
            }
            let displayedArticle: DisplayedArticle
        }
    }
}
