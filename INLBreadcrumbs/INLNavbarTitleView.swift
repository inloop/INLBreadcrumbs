//
//  INLNavbarTitleView.swift
//  INLBreadcrumbs
//
//  Created by Petr Tomicek on 13.12.16.
//  Copyright © 2016 Inloop, s.r.o. All rights reserved.
//

import UIKit

class INLNavbarTitleView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var titleTappedDelegate: (() -> Void)?
    
    var title: String? {
        
        didSet {
            
            titleLabel.text = title
        }
    }
    
    func resize() {
        
        titleLabel.sizeToFit()
        self.frame = CGRect(x: self.frame.origin.x,
                            y: self.frame.origin.y,
                            width: self.titleLabel.frame.size.width,
                            height: self.frame.size.height)
    }
    
    @IBAction func titleTapped(_ sender: Any)
    {
        titleTappedDelegate?()
    }
    
}

