//
//  MenuGroupCell.swift
//  Slide Out Menu
//
//  Created by hosam on 5/20/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class MenuGroupCell: UITableViewCell {

    let bgView:UIView = {
       let bg = UIView()
        bg.backgroundColor = #colorLiteral(red: 0.3202255964, green: 0.5989795327, blue: 0.5417570472, alpha: 1)
        bg.layer.cornerRadius = 5
        return bg
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        addSubview(bgView)
        bgView.fillSuperview(padding: .init(top: 0, left: 4, bottom: 0, right: 4) ) 
        sendSubviewToBack(bgView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        bgView.isHidden = !selected
//        contentView.backgroundColor = selected ? .red : .yellow
    }

}
