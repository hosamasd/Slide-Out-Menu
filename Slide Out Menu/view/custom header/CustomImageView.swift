//
//  CustomImageView.swift
//  Slide Out Menu
//
//  Created by hosam on 5/19/19.
//  Copyright © 2019 hosam. All rights reserved.
//

import UIKit

class CustomImageView: UIImageView {
    let size:CGFloat
    
    override var intrinsicContentSize: CGSize {
        return .init(width: size, height: size)
    }
    
    init(size: CGFloat){
        self.size = size
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
