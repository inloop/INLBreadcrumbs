//
//  INLBreadcrumbCompatibleController.m
//  INLBreadcrumbs
//
//  Created by Tomas Hakel on 02/12/2015.
//  Copyright © 2015 Inloop, s.r.o. See LICENSE.md
//

#import "INLBreadcrumbCompatibleController.h"
#import "INLBreadcrumbManager.h"
#import "INLBreadcrumb.h"
#import "INLNavbarTitleView.h"
#import "UIView+INLViewWithClass.h"
#import "MethodSwizzler.h"

@implementation INLBreadcrumbViewController

+(void)load {
	[super load];
	[self setupBreadcrumbs];
}

-(void)viewDidLoad {
	[super viewDidLoad];
	self.breadcrumb = [INLBreadcrumb breadcrumbWithController:self];
}

@end


@implementation UIViewController (INLBreadcrumbs)

+(void)setupBreadcrumbs {
	replaceMethodImplementations([self class], @selector(didMoveToParentViewController:), @selector(inl_didMoveToParentViewController:));
}

-(void)inl_didMoveToParentViewController:(UIViewController *)parent {
	[self inl_didMoveToParentViewController:parent];
	if ([self conformsToProtocol:@protocol(INLBreadcrumbCompatibleController)]) {
		UIViewController<INLBreadcrumbCompatibleController> * controller = (UIViewController<INLBreadcrumbCompatibleController> *)self;
		if (parent != nil) {
			[controller.breadcrumb.manager pushBreadcrumb:controller.breadcrumb];
		}
		else {
			[controller.breadcrumb.manager popBreadcrumb:controller.breadcrumb];
		}
		[controller.breadcrumb updateTitle];
	}
}

@end
