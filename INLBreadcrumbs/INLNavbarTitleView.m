//
//  INLNavbarTitleView.m
//  INLBreadcrumbs
//
//  Created by Tomas Hakel on 02/12/2015.
//  Copyright © 2015 Inloop, s.r.o. See LICENSE.md
//

#import "INLNavbarTitleView.h"

@implementation INLNavbarTitleView

-(void)resize {
	[self.titleLabel sizeToFit];
	self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.titleLabel.frame.size.width, self.frame.size.height);
}

- (IBAction)titleTapped:(id)sender {
	if (self.onTitleTapped) {
		self.onTitleTapped();
	}
}

-(void)setTitle:(NSString *)title {
	self.titleLabel.text = title;
}

-(NSString *)title {
	return self.titleLabel.text;
}

@end
