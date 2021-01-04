//
//  ViewController.swift
//  StateMachineDemo
//
//  Created by Peter Yo on Dec/30/20.
//

import UIKit
import GameplayKit

class ViewController: UIViewController {

  var stateMachine: GKStateMachine?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // 狀態機初始化之後就不能增減狀態了，所以要在這邊把全部的狀態建構好再拿來建構狀態機。
    stateMachine = GKStateMachine(states: [
        ErrorState(viewController: self),
        EmptyState(viewController: self),
        LoadingState(viewController: self),
        ArticlesState(viewController: self)
    ])
    // 要狀態機先進入空白狀態。
    stateMachine?.enter(EmptyState.self)
  }
  
}


