//
//  UIView+INLViewWithClass.h
//  INLBreadcrumbs
//
//  Created by Tomas Hakel on 02/12/2015.
//  Copyright © 2015 Inloop, s.r.o. See LICENSE.md
//

#import <UIKit/UIKit.h>

@interface UIView (INLViewWithClass)

+(id)viewWithClass:(Class)class;
+(id)viewWithClass:(Class)class fromNibNamed:(NSString *)nibName;

@end
