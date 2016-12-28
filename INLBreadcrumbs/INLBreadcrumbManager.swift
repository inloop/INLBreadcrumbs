//
//  INLBreadcrumbManager.swift
//  INLBreadcrumbs
//
//  Created by Petr Tomicek on 13.12.16.
//  Copyright © 2016 Inloop, s.r.o. All rights reserved.
//

import Foundation

public class INLBreadcrumbManager
{
    var cancelButtonTitle: String?
    var breadcrumbIndicator: String?
    
    static let shared = INLBreadcrumbManager()
    
    private var managers: [String:INLBreadcrumbManager]
    
    private var breadcrumbStack: [INLBreadcrumb]
    
    public init() {
        
        self.breadcrumbStack = []
        self.managers = [:]
    }
    
    public func managerForKey(key: String) ->  INLBreadcrumbManager {
        
        if let manager = managers[key] {
            
            return manager
        }
        else {
            
            let manager = INLBreadcrumbManager()
            managers[key] = manager
            return manager
        }
    }
    
    public func pushBreadcrumb(breadcrumb: INLBreadcrumb) {
        
        self.breadcrumbStack.append(breadcrumb)
    }
    
    public func popBreadcrumb(breadcrumb: INLBreadcrumb) {
        
        self.breadcrumbStack.removeLast()
    }
    
    public func breadcrumbs() -> [INLBreadcrumb] {
        
        return self.breadcrumbStack
    }
}
