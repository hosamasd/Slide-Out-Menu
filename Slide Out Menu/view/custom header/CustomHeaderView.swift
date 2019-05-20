//
//  CustomHeaderView.swift
//  Slide Out Menu
//
//  Created by hosam on 5/19/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class CustomHeaderView: UIView {
    
    let mainImage:CustomImageView = {
       let im = CustomImageView(size: 48)
        im.image = #imageLiteral(resourceName: "profile")
        im.layer.cornerRadius = 48 / 2
         im.clipsToBounds = true
        return im
    }()
    let labelName:UILabel = {
        let la = UILabel(string: "hosam mohamed", font: .boldSystemFont(ofSize: 18),numberOfLines: 0)
        
        return la
    }()
    let labelEmail:UILabel = {
        let la = UILabel(string: "@hosam mohamed", font: .systemFont(ofSize: 16),numberOfLines: 0)
        
        return la
    }()
    let labelFollowers:UILabel = {
        
        let statsLabel = UILabel()
        statsLabel.font = UIFont.systemFont(ofSize: 14)
        let attributedText = NSMutableAttributedString(string: "42 ", attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium)])
        attributedText.append(NSAttributedString(string: "Following  ", attributes: [.foregroundColor: UIColor.black]))
        attributedText.append(NSAttributedString(string: "7091 ", attributes: [.font: UIFont.systemFont(ofSize: 17, weight: .medium)]))
        attributedText.append(NSAttributedString(string: "Followers", attributes: [.foregroundColor: UIColor.black]))
        
        statsLabel.attributedText = attributedText
       return statsLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        setupViews()
    }
    
    func setupViews()  {
        let arragedViews = [
        UIView(),
        UIStackView(arrangedSubviews: [mainImage,UIView()]),
        labelName,
        labelEmail,
        SeperatorView(space: 16),
        labelFollowers
        ]
        
        let mainStack = UIStackView(arrangedSubviews: arragedViews)
//        mainStack.distribution = .fillProportionally
        mainStack.axis = .vertical
        mainStack.spacing = 4
        
        addSubview(mainStack)
        mainStack.fillSuperview(padding: .init(top: 24, left: 24, bottom: 24, right: 24))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
