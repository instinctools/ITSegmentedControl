//
//  ADSegmentView.h
//  Audi-setmented-control
//
//  Created by Alex Rudyak on 5/4/15.
//  Copyright (c) 2015 Alex Rudyak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITSegment.h"

@interface ITSegmentView : ITSegment

- (instancetype)initWithTitle:(NSString *)title;

@property (copy, nonatomic) NSString *title;

- (void)setTitleFont:(UIFont *)font forState:(UIControlState)state;
- (UIFont *)titleFontForState:(UIControlState)state;

- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state;
- (UIColor *)titleColorForState:(UIControlState)state;

@end
