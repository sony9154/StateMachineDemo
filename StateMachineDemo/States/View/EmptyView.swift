//
//  EmptyView.swift
//  StateMachineDemo
//
//  Created by Peter Yo on Jan/4/21.
//

import UIKit

class EmptyView: UIView {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
    }
    
    class func instanceFromNib() -> EmptyView {
        return UINib(nibName: "EmptyView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! EmptyView
    }
}
