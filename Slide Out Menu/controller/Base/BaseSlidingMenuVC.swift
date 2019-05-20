//
//  BaseSlidingMenuVC.swift
//  Slide Out Menu
//
//  Created by hosam on 5/19/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class BaseSlidingMenuVC: UIViewController {

    var redViewLeadingConstraint: NSLayoutConstraint!
    var redViewTrailingConstraint: NSLayoutConstraint!

    let menuVC = ChatMenuContainerVC()
fileprivate let menuWidth: CGFloat = 300
    fileprivate let velocityThreshold: CGFloat = 500
    var isMenuOpened = false
    
    let redView: UIView = {
        let v = UIView()
        v.backgroundColor = .red
        v.translatesAutoresizingMaskIntoConstraints = false

        return v
    }()
    
    let blueView: UIView = {
        let v = UIView()
        v.backgroundColor = .blue
        v.translatesAutoresizingMaskIntoConstraints = false
      return v
    }()
    let darkCoverView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor(white: 0, alpha: 0.7)
        v.alpha = 0
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    var rightViewController: UIViewController = UINavigationController(rootViewController: MainVC())

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        
        setupViews()
        
        setupPangesture()
        setupViewControllers()
        
        darkCoverView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapped)))
    }
    
   
    
    
    
    fileprivate func setupViews() {
        view.addSubview(redView)
        view.addSubview(blueView)
        
        // let's go ahead and use Auto Layout
        NSLayoutConstraint.activate([
            redView.topAnchor.constraint(equalTo: view.topAnchor),
            redView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            

            blueView.topAnchor.constraint(equalTo: view.topAnchor),
            blueView.trailingAnchor.constraint(equalTo: redView.leadingAnchor),
            blueView.widthAnchor.constraint(equalToConstant: menuWidth),
            blueView.bottomAnchor.constraint(equalTo: redView.bottomAnchor)
            ])
        
        self.redViewLeadingConstraint = redView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0)
        //        redViewLeadingConstraint.constant = 150
        redViewLeadingConstraint.isActive = true
        redViewTrailingConstraint = redView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        redViewTrailingConstraint.isActive = true
    }

    func setupViewControllers()  {
       
        
        
        let menuView = menuVC.view!
       let mainView = rightViewController.view!
        
        menuView.translatesAutoresizingMaskIntoConstraints = false
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        redView.addSubview(mainView)
        redView.addSubview(darkCoverView)
        blueView.addSubview(menuView)
        
        NSLayoutConstraint.activate([
            // top, leading, bottom, trailing anchors
            mainView.topAnchor.constraint(equalTo: redView.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: redView.leadingAnchor),
            mainView.bottomAnchor.constraint(equalTo: redView.bottomAnchor),
            mainView.trailingAnchor.constraint(equalTo: redView.trailingAnchor),
            
            menuView.topAnchor.constraint(equalTo: blueView.topAnchor),
            menuView.leadingAnchor.constraint(equalTo: blueView.leadingAnchor),
            menuView.bottomAnchor.constraint(equalTo: blueView.bottomAnchor),
            menuView.trailingAnchor.constraint(equalTo: blueView.trailingAnchor),
            
            darkCoverView.topAnchor.constraint(equalTo: redView.topAnchor),
            darkCoverView.leadingAnchor.constraint(equalTo: redView.leadingAnchor),
            darkCoverView.bottomAnchor.constraint(equalTo: redView.bottomAnchor),
            darkCoverView.trailingAnchor.constraint(equalTo: redView.trailingAnchor),
            ])
//        mainView.anchor(top: redView.topAnchor, leading: redView.leadingAnchor, bottom: redView.bottomAnchor, trailing: redView.trailingAnchor)
//        menuView.anchor(top: blueView.topAnchor, leading: blueView.leadingAnchor, bottom: blueView.bottomAnchor, trailing: blueView.trailingAnchor)
        
        addChild(rightViewController)
        addChild(menuVC)
    }
    
    fileprivate func setupPangesture() {
        // how do we translate our red view
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(panGesture)
    }

    
    
    func handleEnded(_ gesture:UIPanGestureRecognizer) {
        let translate = gesture.translation(in: view)
        let velocity = gesture.velocity(in: view)
        
        // Cleaning up this section of code to solve for Lesson #10 Challenge of velocity and darkCoverView
        if isMenuOpened {
            if abs(velocity.x) > velocityThreshold {
                closeMenu()
                return
            }
            if abs(translate.x) < menuWidth / 2 {
                openMenu()
            } else {
                closeMenu()
            }
        } else {
            if abs(velocity.x) > velocityThreshold {
                openMenu()
                return
            }
            
            if translate.x < menuWidth / 2 {
                closeMenu()
            } else {
                openMenu()
            }
        }
       
     }
    
    func didSelectItemAtIndex(index:IndexPath)  {
        performRightViewCleanUp()
         closeMenu()
        
        switch index.row {
        case 0:
            rightViewController = UINavigationController(rootViewController: MainVC())
        case 1:
            rightViewController = UINavigationController(rootViewController: ListVC())
        case 2:
           rightViewController = BookmarkVC()
        default:
           
            let tabBarController = UITabBarController()
            let momentsController = UIViewController()
            momentsController.navigationItem.title = "Moments"
            momentsController.view.backgroundColor = .orange
            let navController = UINavigationController(rootViewController: momentsController)
            navController.tabBarItem.title = "Moments"
            tabBarController.viewControllers = [navController]
            rightViewController = tabBarController
        }
        redView.addSubview(rightViewController.view)
        addChild(rightViewController)
        redView.bringSubviewToFront(darkCoverView)
       
    }
    
    func performRightViewCleanUp()  {
        rightViewController.view.removeFromSuperview()
        rightViewController.removeFromParent()
    }
    
   
    
    fileprivate func performAnimations() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
            self.darkCoverView.alpha = self.isMenuOpened ? 1 : 0
        })
    }
    
     func openMenu() {
        isMenuOpened = true
        redViewLeadingConstraint.constant = menuWidth
        performAnimations()
        setNeedsStatusBarAppearanceUpdate() // for indicate system to any changes in status bar
    }
    
     func closeMenu() {
        redViewLeadingConstraint.constant = 0
        redViewTrailingConstraint.constant = 0
        isMenuOpened = false
        performAnimations()
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return isMenuOpened ? .lightContent : .default
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        var x = translation.x
        
        x = isMenuOpened ? x + menuWidth : x
        x = min(menuWidth, x)
        x = max(0, x)
        
        redViewLeadingConstraint.constant = x
        redViewTrailingConstraint.constant = x
         darkCoverView.alpha = x / menuWidth
        if gesture.state == .ended {
            handleEnded(gesture)
        }
    }
    
   @objc func handleTapped()  {
        closeMenu()
    }
    
}
