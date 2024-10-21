//
//  NewsListRouter.swift
//  Buzz
//
//  Created by Vitor Henrique Barreiro Marinho on 18/10/24.
//

import UIKit

class NewsListRouter {
    static func createInitialViewController() -> UIViewController {
        let controller = NewsListViewController()
        let navigationController = UINavigationController(rootViewController: controller)
        return navigationController
    }
}
