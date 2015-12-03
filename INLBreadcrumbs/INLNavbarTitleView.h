//
//  INLNavbarTitleView.h
//  INLBreadcrumbs
//
//  Created by Tomas Hakel on 02/12/2015.
//  Copyright © 2015 Inloop, s.r.o. See LICENSE.md
//

#import <UIKit/UIKit.h>

@interface INLNavbarTitleView : UIView

@property (weak, nonatomic) IBOutlet UILabel * titleLabel;
@property (weak, nonatomic) NSString * title;

@property (strong, nonatomic) void(^onTitleTapped)();

@end
