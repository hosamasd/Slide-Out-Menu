//
//  ListVC.swift
//  Slide Out Menu
//
//  Created by hosam on 5/19/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class ListVC: UIViewController {
    
    lazy var mainLabel:UILabel = {
        let label = UILabel()
        label.text = "Lists"
        label.font = UIFont.boldSystemFont(ofSize: 64)
        label.frame = view.frame
        label.textAlignment = .center
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(mainLabel)
    }
}
