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
    private var emptyView = EmptyView.instanceFromNib()
    
    // 將 emptyView 加到 view 裡面。
    override func didEnter(from previousState: GKState?) {
        emptyView.button.addTarget(self, action: #selector(didPressButton(_:)), for: .touchUpInside)
        view.addSubview(emptyView)
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
