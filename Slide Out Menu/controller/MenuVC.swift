//
//  m.swift
//  Slide Out Menu
//
//  Created by hosam on 5/18/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class MenuVC: UITableViewController {
    let cellid = "cellid"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableview()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath)
        
        cell.textLabel?.text = "Menu "
        return cell
    }
    
    func setupTableview()  {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellid)
        tableView.backgroundColor = .green
    }
}
