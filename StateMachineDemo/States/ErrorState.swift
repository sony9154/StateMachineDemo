//
//  ErrorState.swift
//  StateMachineDemo
//
//  Created by Peter Yo on Dec/30/20.
//

import Foundation
import UIKit
import GameplayKit

class ErrorState: ViewControllerState {

    // 將要顯示的 Error。
    var error: Error?

    // 顯示中的 alertController。
    var alertController: UIAlertController?

    // 呈現一個 UIAlertController。
    override func didEnter(from previousState: GKState?) {

        guard let error = error else { return }
        let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        self.alertController = alertController

        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel) { [weak self] action in

            // 如果選擇取消的話，進到空白狀態。
            self?.stateMachine?.enter(EmptyState.self)
        }
        alertController.addAction(dismissAction)

        let retryAction = UIAlertAction(title: "Retry", style: .default) { [weak self] action in

            // 如果選擇重試的話，進到載入中狀態。
            self?.stateMachine?.enter(LoadingState.self)
        }
        alertController.addAction(retryAction)

        viewController.present(alertController, animated: true)
    }

    // 以防 alertController 還沒被去除掉。
    override func willExit(to nextState: GKState) {
        if alertController != nil, alertController === viewController.presentedViewController {
            viewController.dismiss(animated: true)
        }
        alertController = nil
    }
}
