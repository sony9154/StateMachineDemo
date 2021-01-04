//
//  ArticlesState.swift
//  StateMachineDemo
//
//  Created by Peter Yo on Dec/30/20.
//

import Foundation
import UIKit
import GameplayKit

// UITableViewDataSource 所用。
private let cellReuseIdentifier = "Cell"

class ArticlesState: ViewControllerState {

    // 持有 articles。
    var articles = [Article]()

    // 創造一個 UITableView。
    private var articleTableView = ArticleTableView.instanceFromNib()

    // 將 tableView 顯示出來。
    override func didEnter(from previousState: GKState?) {
        articleTableView.tableView.delegate = self
        articleTableView.tableView.dataSource = self
        articleTableView.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        view.addSubview(articleTableView)
        articleTableView.tableView.reloadData()
    }

    // 移除 tableView。
    override func willExit(to nextState: GKState) {
        articleTableView.removeFromSuperview()
    }
}

// 實作 UITableViewDataSource。
extension ArticlesState: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articles.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        let article = articles[indexPath.row]
        cell.textLabel?.text = article.title
        return cell
    }
}

// 實作 UITableViewDelegate。
extension ArticlesState: UITableViewDelegate {

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [
            .init(style: .destructive, title: "Delete") { [weak self] action, sourceView, completion in
                guard let self = self else { completion(false); return }

                // 刪除條目。
                self.articles.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)

                // 如果沒有剩下條目的話，就進入到空白狀態。
                if self.articles.isEmpty {
                    self.stateMachine?.enter(EmptyState.self)
                }

                completion(true)
            }
        ])
    }
}
