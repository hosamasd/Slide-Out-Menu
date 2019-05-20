//
//  ViewController.swift
//  Slide Out Menu
//
//  Created by hosam on 5/18/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class MainVC: UITableViewController {
    
    let menuVC = MenuVC()
    let darkCoverView = UIView()
    
    fileprivate  let cellid = "cellid"
    fileprivate let velocityOpenedThreshold:CGFloat = 500
    fileprivate  let menuWidth:CGFloat = 300
    var isMenuOpened = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigatioItems()
        setupTableview()
        
        setupVC()
        setupDarkCoverView()
    }
    
    //MARK:-UITableView methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath)
        
        cell.textLabel?.text = "row \(indexPath.row)"
        
        return cell
    }
    
    //MARK:- user methods
    
    fileprivate  func setupNavigatioItems()  {
        navigationItem.title = "Home"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "hide", style: .plain, target: self, action: #selector(handleHide))
        
        setupCircularNavItem()
    }
    
    fileprivate  func setupDarkCoverView()  {
        darkCoverView.alpha = 0
        darkCoverView.backgroundColor = UIColor(white: 0, alpha: 0.8)
        let mainKeyq =  UIApplication.shared.keyWindow
        mainKeyq?.addSubview(darkCoverView)
        darkCoverView.isUserInteractionEnabled = false
        darkCoverView.frame = mainKeyq?.frame ?? .zero
    }
    
    fileprivate func setupCircularNavItem()  {
        let image = #imageLiteral(resourceName: "girl_profile").withRenderingMode(.alwaysOriginal)
        
        let customView = UIButton(type: .system)
        customView.addTarget(self, action: #selector(handleShow), for: .touchUpInside)
        customView.setImage(image, for: .normal)
        customView.imageView?.contentMode = .scaleAspectFit
        
        customView.layer.cornerRadius = 20
        customView.clipsToBounds = true
        
        
        customView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        customView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        let barButtonItem = UIBarButtonItem(customView: customView)
        
        navigationItem.leftBarButtonItem = barButtonItem
    }
    
    fileprivate  func setupTableview()  {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellid)
        tableView.backgroundColor = .red
    }
    
    fileprivate func setupVC() {
        menuVC.view.frame = CGRect(x: -menuWidth, y: 0, width: menuWidth, height: view.frame.height)
        let mainwindow = UIApplication.shared.keyWindow
        mainwindow?.addSubview(menuVC.view)
        addChild(menuVC)
    }
    
    fileprivate func makeAnimation(transform: CGAffineTransform) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.menuVC.view.transform = transform
            self.navigationController?.view.transform = transform
            self.darkCoverView.transform =  transform
            
            self.darkCoverView.alpha = transform == .identity ? 0 : 1
        })
    }
    
    fileprivate func handleEnde1d(gesture:UIPanGestureRecognizer)  {
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
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        panGesture.delegate = self
        view.addGestureRecognizer(panGesture)
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
            
            menuVC.view.transform = transform
            navigationController?.view.transform = transform
            darkCoverView.transform = transform
            
            darkCoverView.alpha = x / menuWidth
        }else if gesture.state == .ended {
            handleEnde1d(gesture: gesture)
        }
    }
    
    @objc func handleShow() {
        (UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingMenuVC)?.openMenu()
    }
    
    @objc func handleHide() {
        (UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingMenuVC)?.closeMenu()
    }
    
}

extension MainVC: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
