//
//  INLBreadcrumb.m
//  INLBreadcrumbs
//
//  Created by Tomas Hakel on 02/12/2015.
//  Copyright © 2015 Inloop, s.r.o. See LICENSE.md
//

#import "INLBreadcrumb.h"
#import "INLBreadcrumbCompatibleController.h"
#import "INLNavbarTitleView.h"
#import "INLBreadcrumbManager.h"
#import "UIView+INLViewWithClass.h"
#import "MethodSwizzler.h"

@implementation INLBreadcrumb

+(instancetype)breadcrumbWithController:(UIViewController<INLBreadcrumbCompatibleController> *)controller {
	return [[INLBreadcrumb alloc] initWithController:controller];
}

-(instancetype)initWithController:(UIViewController<INLBreadcrumbCompatibleController> *)controller {
	return [self initWithController:controller manager:[INLBreadcrumbManager defaultManager]];
}

+(instancetype)breadcrumbWithController:(UIViewController<INLBreadcrumbCompatibleController> *)controller manager:(INLBreadcrumbManager *)manager {
	return [[INLBreadcrumb alloc] initWithController:controller manager:manager ? manager : [INLBreadcrumbManager defaultManager]];
}

-(instancetype)initWithController:(UIViewController<INLBreadcrumbCompatibleController> *)controller manager:(INLBreadcrumbManager *)manager {
	if (self = [super init]) {
		self.controller = controller;
		self.manager = manager;
		self.cancelButtonTitle = manager.cancelButtonTitle ? manager.cancelButtonTitle : @"Cancel";
		self.breadcrumbIndicator = manager.breadcrumbIndicator ? manager.breadcrumbIndicator : @" ▾";
		self.titleView = [UIView viewWithClass:[INLNavbarTitleView class]];
		[self updateTitle];
		
		__weak typeof(self) weakSelf = self;
		self.titleView.onTitleTapped = ^{
			[weakSelf onTitleTapped];
		};
	}
	return self;
}

-(BOOL)isTopBreadcrumb {
	return [self.manager breadcrumbs].count == 0 || [self.manager breadcrumbs][0].controller == self.controller;
}

-(void)onTitleTapped {
	if ([self isTopBreadcrumb]) {
		return;
	}
	UIAlertController * popup = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
	
	NSArray<INLBreadcrumb *> * breadcrumbs = [self.manager breadcrumbs];
	for (NSInteger i = breadcrumbs.count-2; 0 <= i; --i) {
		[popup addAction:[UIAlertAction actionWithTitle:breadcrumbs[i].title style:UIAlertActionStyleDefault
			handler:^(UIAlertAction * action) {
				[self.controller.navigationController popToViewController:(UIViewController *)breadcrumbs[i].controller animated:YES];
			}]];		
	}
	[popup addAction:[UIAlertAction actionWithTitle:self.cancelButtonTitle style:UIAlertActionStyleCancel handler:nil]];
	
	popup.popoverPresentationController.sourceView = self.controller.navigationItem.titleView;
	popup.popoverPresentationController.sourceRect = CGRectMake(0, 0,
																self.controller.navigationItem.titleView.frame.size.width,
																self.controller.navigationItem.titleView.frame.size.height);
	[self.controller presentViewController:popup animated:YES completion:nil];
}

-(INLNavbarTitleView *)titleView {
	return (INLNavbarTitleView *)self.controller.navigationItem.titleView;
}

-(void)setTitleView:(INLNavbarTitleView *)titleView {
	self.controller.navigationItem.titleView = titleView;
}

-(void)updateTitle {
	NSString * title = self.title;
	if (![self isTopBreadcrumb] && self.breadcrumbIndicator) {
		title = [self.title stringByAppendingString:self.breadcrumbIndicator];
	}
	self.titleView.title = title;
}

-(NSString *)title {
	return self.controller.title;
}

-(void)setBreadcrumbIndicator:(NSString *)breadcrumbIndicator {
	_breadcrumbIndicator = breadcrumbIndicator;
	[self updateTitle];
}

@end
