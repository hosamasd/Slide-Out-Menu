//
//  ViewController.swift
//  Slide Out Menu
//
//  Created by hosam on 5/18/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

     let vc = MenuVC()
    let cellid = "cellid"
    let menuWidth:CGFloat = 300
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupNavigatioItems()
        setupTableview()
        
        setupVC()
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath)
        
        cell.textLabel?.text = "row \(indexPath.row)"
        
        return cell
    }

    func setupNavigatioItems()  {
        navigationItem.title = "home"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "hide", style: .plain, target: self, action: #selector(handleHide))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "open", style: .plain, target: self, action: #selector(handleShow))

    }
    
    func setupTableview()  {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellid)
        tableView.backgroundColor = .red
    }
    
    fileprivate func setupVC() {
        vc.view.frame = CGRect(x: -menuWidth, y: 0, width: menuWidth, height: view.frame.height)
        let mainwindow = UIApplication.shared.keyWindow
        mainwindow?.addSubview(vc.view)
        addChild(vc)
    }
    
    fileprivate func makeAnimation(transform: CGAffineTransform) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.vc.view.transform = transform
//            self.view.transform = transform
            self.navigationController?.view.transform = transform
        })
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer)  {
        let translate = gesture.translation(in: view)
        print(translate)
        if gesture.state == .changed {
            var x = translate.x
            x = min(menuWidth, x)
            x = max(0, x)
            let transform = CGAffineTransform(translationX: x, y: 0)
            
            vc.view.transform = transform
            navigationController?.view.transform = transform
        }else if gesture.state == .ended {
            handleShow()
        }
    }
    
    @objc func handleHide(){
        
        makeAnimation(transform: .identity)
    }
    
   
    
    @objc func handleShow(){
        makeAnimation(transform: CGAffineTransform(translationX: self.menuWidth, y: 0))
       
    }
}

