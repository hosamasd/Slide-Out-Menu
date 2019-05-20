//
//  ChatRoomGroupVC.swift
//  Slide Out Menu
//
//  Created by hosam on 5/19/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class ChatMenuGroupVC: UITableViewController {
    let cellId = "cellId"
    
    let chatroomGroups = [
        ["general", "introductions"],
        ["jobs"],
        ["Brian Voong", "Steve Jobs", "Tim Cook", "Barack Obama"]
    ]
    var filteredArray = [[String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filteredArray = chatroomGroups
        setupTableView()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return filteredArray.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "UNREADS" : section == 1 ? "CHANNELS" : "DIRECT MESSAGES"
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let text = section == 0 ? "UNREADS" : section == 1 ? "CHANNELS" : "DIRECT MESSAGES"
        
        let lab = HeightForHeaderLabel()
        lab.text = text
        lab.textColor = #colorLiteral(red: 0.4745098039, green: 0.4078431373, blue: 0.4666666667, alpha: 1)
        return lab
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredArray[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MenuGroupCell
        
       
        // so what is the text to fill out?
        let text = filteredArray[indexPath.section][indexPath.row]
        let attributedText = NSMutableAttributedString(string: "#  ", attributes: [.foregroundColor:  #colorLiteral(red: 0.4745098039, green: 0.4078431373, blue: 0.4666666667, alpha: 1), .font: UIFont.systemFont(ofSize: 18, weight: .regular)])
        attributedText.append(NSAttributedString(string: text, attributes: [.foregroundColor: UIColor.white]))
        cell.textLabel?.attributedText = attributedText
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
        return cell
    }
    
    func setupTableView()  {
        tableView.separatorStyle = .none
        tableView.register(MenuGroupCell.self, forCellReuseIdentifier: cellId)
        tableView.backgroundColor = #colorLiteral(red: 0.2980392157, green: 0.2078431373, blue: 0.2862745098, alpha: 1)
    }
}

class HeightForHeaderLabel: UILabel {
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.insetBy(dx: 16, dy: 0))
    }
}

extension ChatMenuGroupVC: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredArray = chatroomGroups
            tableView.reloadData()
            return
        }
        
        //multi line for fetch
//        var results = [[String]]()
//
//        self.chatroomGroups.forEach { (group) in
//            let filtered = group.filter({ (name) -> Bool in
//                return name.lowercased().contains(searchText.lowercased())
//            })
//            results.append(filtered)
//        }
//        print(results)
//        filteredArray = results
        
        //single line for fetch
        filteredArray = chatroomGroups.map({ (group) -> [String] in
            group.filter {$0.lowercased().contains(searchText.lowercased()) }
        })
        tableView.reloadData()
    }
}
