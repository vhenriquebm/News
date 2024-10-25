//
//  NewsListRouter.swift
//  Buzz
//
//  Created by Vitor Henrique Barreiro Marinho on 18/10/24.
//

import UIKit

protocol NewsListRoutingLogic {
    var viewController: NewsListViewController? { get set }
    func routeToNewsDetails(articleId: Int)
}

class NewsListRouter: NewsListRoutingLogic {
    var viewController: NewsListViewController?
    
    func routeToNewsDetails(articleId: Int) {
        let detailsController = NewsListDetailsViewController(articleId: articleId)
        viewController?.navigationController?.pushViewController(detailsController, animated: true)
    }
    
    static func createInitialViewController() -> UIViewController {
        let controller = NewsListViewController()
        let navigationController = UINavigationController(rootViewController: controller)
        return navigationController
    }
}
