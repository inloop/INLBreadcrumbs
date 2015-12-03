//
//  INLBreadcrumbCompatibleController.h
//  INLBreadcrumbs
//
//  Created by Tomas Hakel on 02/12/2015.
//  Copyright © 2015 Inloop, s.r.o. See LICENSE.md
//

#import <UIKit/UIKit.h>
#import "INLBreadcrumb.h"

@protocol INLBreadcrumbCompatibleController <NSObject>

@property (strong, nonatomic) INLBreadcrumb * breadcrumb;

@end


@interface INLBreadcrumbViewController : UIViewController <INLBreadcrumbCompatibleController>

@property (strong, nonatomic) INLBreadcrumb * breadcrumb;

@end


@interface UIViewController (INLBreadcrumbs)

+(void)setupBreadcrumbs;

@end