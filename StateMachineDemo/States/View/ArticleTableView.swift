//
//  ArticleTableView.swift
//  StateMachineDemo
//
//  Created by Peter Yo on Jan/4/21.
//

import UIKit

class ArticleTableView: UIView {

    @IBOutlet weak var tableView: UITableView!
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        
    }
    

    class func instanceFromNib() -> ArticleTableView {
        return UINib(nibName: "ArticleTableView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! ArticleTableView
    }
    
}
