//
//  INLBreadcrumbService.m
//  INLBreadcrumbs
//
//  Created by Tomas Hakel on 02/12/2015.
//  Copyright © 2015 Inloop, s.r.o. See LICENSE.md
//

#import "INLBreadcrumbManager.h"
#import "INLBreadcrumb.h"
#import "INLBreadcrumbCompatibleController.h"

@interface INLBreadcrumbManager ()

@property (strong, nonatomic) NSMutableArray<INLBreadcrumb *> * breadcrumbStack;

@end


@implementation INLBreadcrumbManager

-(instancetype)init {
	if (self = [super init]) {
		self.breadcrumbStack = [@[] mutableCopy];
		self.cancelButtonTitle = nil;
		self.breadcrumbIndicator = nil;
	}
	return self;
}

-(NSArray<INLBreadcrumb *> *)breadcrumbs {
	return self.breadcrumbStack;
}

-(void)pushBreadcrumb:(INLBreadcrumb *)breadcrumb {
	[self.breadcrumbStack addObject:breadcrumb];
}

-(void)popBreadcrumb:(INLBreadcrumb *)breadcrumb {
	[self.breadcrumbStack removeLastObject];
}

+(instancetype)defaultManager {
	static INLBreadcrumbManager * defaultManager = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		defaultManager = [[INLBreadcrumbManager alloc] init];
	});
	return defaultManager;
}

+(instancetype)managerForKey:(NSString *)key {
	static NSMutableDictionary<NSString *, INLBreadcrumbManager *> * managers = nil;
	if (!managers) { managers = [@{} mutableCopy]; }
	
	INLBreadcrumbManager * manager = managers[key];
	if (!manager) {
		manager = [[INLBreadcrumbManager alloc] init];
		managers[key] = manager;
	}
	return manager;
}

@end
