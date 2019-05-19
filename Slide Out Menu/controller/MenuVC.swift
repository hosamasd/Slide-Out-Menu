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
    let menuItems = [
        MenuModel(icon: #imageLiteral(resourceName: "profile"), title: "Profile"),
        MenuModel(icon: #imageLiteral(resourceName: "lists"), title: "Lists"),
        MenuModel(icon: #imageLiteral(resourceName: "bookmarks"), title: "Bookmarks"),
        MenuModel(icon: #imageLiteral(resourceName: "moments"), title: "Moments"),
        ]
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableview()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let custom = CustomHeaderView()
        
        return custom
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! MenuCell
        let model = menuItems[indexPath.row]
        
        cell.model = model
        
        return cell
    }
    
    func setupTableview()  {
        tableView.register(MenuCell.self, forCellReuseIdentifier: cellid)
        tableView.backgroundColor = .white
        tableView.tableFooterView = UIView()
    }
}
