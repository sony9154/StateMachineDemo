//
//  EmptyState.swift
//  StateMachineDemo
//
//  Created by Peter Yo on Dec/30/20.
//

import Foundation
import UIKit
import GameplayKit


class EmptyState: ViewControllerState {

    // 創造包含標籤與按鈕的 emptyView。
    // 設定按鈕的 target 為 self。
    // 用 private 把 emptyView 封裝起來。
    private lazy var emptyView: UIView = {
        let label = UILabel()
        label.text = "No Article"
        let button = UIButton(type: .system)
        button.setTitle("Load Articles", for: .normal)
        button.addTarget(self, action: #selector(didPressButton(_:)), for: .touchUpInside)
        let stackView = UIStackView(arrangedSubviews: [label, button])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    // 將 emptyView 加到 view 裡面。
    override func didEnter(from previousState: GKState?) {
        view.addSubview(emptyView)
        NSLayoutConstraint.activate([
            emptyView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

  // 按下載入按鈕時，呼叫 stateMachine 進入載入狀態。
      @objc func didPressButton(_ sender: UIButton) {
          stateMachine?.enter(LoadingState.self)
      }
  
  
  // 在離開狀態之前，把 emptyView 從 View 階層移除。
      override func willExit(to nextState: GKState) {
          emptyView.removeFromSuperview()
      }
}
