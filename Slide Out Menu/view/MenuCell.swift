//
//  MenuCell.swift
//  Slide Out Menu
//
//  Created by hosam on 5/19/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class MenuCell: UITableViewCell {
    
    var model:MenuModel? {
        didSet{
            mainImage.image = model?.icon
            labelTitle.text = model?.title
        }
    }
    
    let mainImage:CustomImageView = {
        let im = CustomImageView(size: 48)
        im.image = #imageLiteral(resourceName: "bookmarks")
        im.layer.cornerRadius = 48 / 2
        im.clipsToBounds = true
        return im
    }()
    let labelTitle:UILabel = {
        let la = UILabel(string: "homepage", font: .boldSystemFont(ofSize: 18),numberOfLines:0)
        
        return la
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
    }
    
    func setupViews()  {
        backgroundColor = .white
        let arragedViews = [
          mainImage,
           labelTitle,
           UIView()
        ]
        let mainStack = UIStackView(arrangedSubviews: arragedViews)
        mainStack.spacing = 12
        addSubview(mainStack)
        
        mainStack.fillSuperview(padding: .init(top: 8, left: 12, bottom: 8, right: 12))
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
