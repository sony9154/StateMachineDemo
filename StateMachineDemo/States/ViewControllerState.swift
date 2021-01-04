//
//  ViewControllerState.swift
//  StateMachineDemo
//
//  Created by Peter Yo on Dec/30/20.
//

import Foundation
import GameplayKit

class ViewControllerState: GKState {
  
  unowned let viewController: ViewController
  
  var view: UIView {
    viewController.view
  }
  
  init(viewController: ViewController) {
    self.viewController = viewController
  }
  
}
