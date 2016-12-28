//
//  INLBreadcrumbViewController.swift
//  INLBreadcrumbs
//
//  Created by Petr Tomicek on 13.12.16.
//  Copyright © 2016 Inloop, s.r.o. All rights reserved.
//

import UIKit

public protocol INLBreadcrumbCompatibleController
{
    var breadcrumb: INLBreadcrumb? { get set }
}

open class INLBreadcrumbViewController: UIViewController, INLBreadcrumbCompatibleController
{
    public var breadcrumb: INLBreadcrumb?
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.breadcrumb = INLBreadcrumb.breadcrumb(with: self)
    }
    
    open override func didMove(toParentViewController parent: UIViewController?)
    {
        super.didMove(toParentViewController: parent)
        
        if parent != nil, let breadcrumb = self.breadcrumb
        {
            self.breadcrumb?.manager.pushBreadcrumb(breadcrumb: breadcrumb)
        }
        else if let breadcrumb = self.breadcrumb
        {
            self.breadcrumb?.manager.popBreadcrumb(breadcrumb: breadcrumb)
        }
        
        self.breadcrumb?.updateTitle()
    }
    
    open override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator)
    {
        self.presentedViewController?.dismiss(animated: true, completion: nil)
    }
}
