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
	[self replaceMethodImplementation:@selector(didMoveToParentViewController:)
								 with:@selector(inl_didMoveToParentViewController:)];
	[self replaceMethodImplementation:@selector(viewWillTransitionToSize:withTransitionCoordinator:)
								 with:@selector(inl_viewWillTransitionToSize:withTransitionCoordinator:)];
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

-(void)inl_viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
	[self inl_viewWillTransitionToSize:size withTransitionCoordinator:coordinator];

	if ([[self.presentedViewController associatedProperty:@selector(setupBreadcrumbs)] boolValue] == YES) {
		[self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
	}
}

@end
