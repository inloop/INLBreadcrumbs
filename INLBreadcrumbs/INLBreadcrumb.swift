//
//  INLBreadcrumb.swift
//  INLBreadcrumbs
//
//  Created by Petr Tomicek on 13.12.16.
//  Copyright © 2016 Inloop, s.r.o. All rights reserved.
//

import Foundation
import UIKit

public class INLBreadcrumb
{
    unowned var controller: INLBreadcrumbViewController
    unowned var manager: INLBreadcrumbManager
    var titleView: INLNavbarTitleView
    
    private var cancelButtonTitle: String
    private var breadcrumbIndicator: String
    
    
    class func breadcrumb(with controller: INLBreadcrumbViewController) -> INLBreadcrumb {
        
        return INLBreadcrumb(with: controller)
    }
    
    convenience init(with controller: INLBreadcrumbViewController) {
        
        self.init(with: controller, manager: INLBreadcrumbManager.shared)
    }
    
    class func breadcrumb(with controller: INLBreadcrumbViewController, manager: INLBreadcrumbManager) -> INLBreadcrumb {
        
        return INLBreadcrumb(with: controller, manager: manager)
    }
    
    init(with controller: INLBreadcrumbViewController, manager: INLBreadcrumbManager) {
        
        self.controller = controller
        self.manager = manager
        
        if let title = manager.cancelButtonTitle {
            
            self.cancelButtonTitle = title
        }
        else {
            
            self.cancelButtonTitle = "Cancel"
        }
        
        if let indicator = manager.breadcrumbIndicator {
            
            self.breadcrumbIndicator = indicator
        }
        else {
            
            self.breadcrumbIndicator = " ▾"
        }
        
        let nib = Bundle(for: INLNavbarTitleView.self)
        let titleview = (UINib(nibName: "INLNavbarTitleView", bundle: nib).instantiate(withOwner: nil, options: nil)[0])
        
        self.titleView = titleview as! INLNavbarTitleView
        self.updateTitle()
        self.titleView.titleTappedDelegate = { () in
            
            self.onTitleTapped()
        }
        self.controller.navigationItem.titleView = self.titleView
        
    }
    
    func isTopBreadcrumb() -> Bool {
        
        return ((self.manager.breadcrumbs().count == 0) || (self.manager.breadcrumbs()[0].controller == self.controller))
    }
    
    func updateTitle() {
        
        var _title = self.getTitle()
        
        if !self.isTopBreadcrumb() {
            
            _title = self.getTitle()?.appending(breadcrumbIndicator)
        }
        self.titleView.title = _title
    }
    
    func getTitle() -> String? {
        
        return self.controller.title
    }
    
    private func onTitleTapped() {
        
        if self.isTopBreadcrumb()
        {
            return
        }
        
        let popup = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        var breadcrumbs = self.manager.breadcrumbs()
        
        for i in stride(from: breadcrumbs.count-2, to: -1, by: -1)  {
            
            popup.addAction(UIAlertAction(title: breadcrumbs[i].getTitle(), style: .default, handler: { (action) in
                
                self.controller.navigationController?.popToViewController(breadcrumbs[i].controller, animated: true)
            }))
        }
        
        popup.addAction(UIAlertAction(title: self.cancelButtonTitle, style: .cancel, handler: nil))
        
        popup.popoverPresentationController?.sourceView = self.controller.navigationItem.titleView
        
        popup.popoverPresentationController?.sourceRect = CGRect(x: 0, y: 0, width: self.controller.navigationItem.titleView?.frame.size.width ?? 0, height: self.controller.navigationItem.titleView?.frame.size.height ?? 0)
        
        //[popup setAssociatedProperty:@selector(setupBreadcrumbs) value:@YES];
        
        self.controller.present(popup, animated: true, completion: nil)
    }
    
    func setBreadcrumbIndicator(indicator: String) {
        
        self.breadcrumbIndicator = indicator
        self.updateTitle()
    }
}

