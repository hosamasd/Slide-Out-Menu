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
    let darkCoverView = UIView()
    
    let cellid = "cellid"
    fileprivate let velocityOpenedThreshold:CGFloat = 500
  fileprivate  let menuWidth:CGFloat = 300
    var isMenuOpened = false
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigatioItems()
        setupTableview()
        
        setupVC()
        setupPanGesture()
        setupDarkCoverView()
    }

    func setupDarkCoverView()  {
        darkCoverView.alpha = 0
        darkCoverView.backgroundColor = UIColor(white: 0, alpha: 0.8)
        let mainKeyq =  UIApplication.shared.keyWindow
        mainKeyq?.addSubview(darkCoverView)
        darkCoverView.isUserInteractionEnabled = false
        darkCoverView.frame = mainKeyq?.frame ?? .zero
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath)
        
        cell.textLabel?.text = "row \(indexPath.row)"
        
        return cell
    }

    //MARK:- user methods
    
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
            self.darkCoverView.transform =  transform
            
            self.darkCoverView.alpha = transform == .identity ? 0 : 1
        })
    }
    
    func handleEnde1d(gesture:UIPanGestureRecognizer)  {
        let translate = gesture.translation(in: view)
        let velcoity = gesture.velocity(in: view)
        
       if isMenuOpened {
            if abs(velcoity.x) > velocityOpenedThreshold {
                handleHide()
                return
            }
            if abs(translate.x) < menuWidth / 2 {
                handleShow()
            }else{
                handleHide()
            }
            
        }else {
            if velcoity.x > velocityOpenedThreshold {
                handleShow()
                return
            }
            
        if translate.x < menuWidth / 2 {
            handleHide()
        }else {
            handleShow()
        }
        }
    }
    
    fileprivate func setupPanGesture() {
        view.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan)))
    }
    
    //TODO: - handle methods
    
    @objc func handlePan(gesture: UIPanGestureRecognizer)  {
        let translate = gesture.translation(in: view)
        if gesture.state == .changed {
            var x = translate.x
            
            if isMenuOpened{
                x += menuWidth
            }
            x = min(menuWidth, x)
            x = max(0, x)
            let transform = CGAffineTransform(translationX: x, y: 0)
            
            vc.view.transform = transform
            navigationController?.view.transform = transform
            darkCoverView.transform = transform
            
            darkCoverView.alpha = x / menuWidth
        }else if gesture.state == .ended {
           handleEnde1d(gesture: gesture)
        }
    }
    
   
    
    @objc func handleHide(){
        isMenuOpened = false
        makeAnimation(transform: .identity)
    }
    
   
    
    @objc func handleShow(){
        isMenuOpened = true
        makeAnimation(transform: CGAffineTransform(translationX: self.menuWidth, y: 0))
       
    }
}

