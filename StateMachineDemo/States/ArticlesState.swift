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
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // 將 tableView 顯示出來。
    override func didEnter(from previousState: GKState?) {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
            view.topAnchor.constraint(equalTo: tableView.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        tableView.reloadData()
    }

    // 移除 tableView。
    override func willExit(to nextState: GKState) {
        tableView.removeFromSuperview()
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
