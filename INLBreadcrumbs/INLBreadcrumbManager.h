//
//  INLBreadcrumbService.h
//  INLBreadcrumbs
//
//  Created by Tomas Hakel on 02/12/2015.
//  Copyright © 2015 Inloop, s.r.o. See LICENSE.md
//

#import <Foundation/Foundation.h>

@class INLBreadcrumbCompatibleController, INLBreadcrumb;

@interface INLBreadcrumbManager : NSObject

@property (strong, nonatomic) NSString * cancelButtonTitle;
@property (strong, nonatomic) NSString * breadcrumbIndicator;

+(instancetype)defaultManager;
+(instancetype)managerForKey:(NSString *)key;

-(NSArray<INLBreadcrumb *> *)breadcrumbs;

-(void)pushBreadcrumb:(INLBreadcrumb *)breadcrumb;
-(void)popBreadcrumb:(INLBreadcrumb *)breadcrumb;

@end
