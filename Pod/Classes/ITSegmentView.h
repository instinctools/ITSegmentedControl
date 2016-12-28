//
//  ADSegmentView.h
//  Audi-setmented-control
//
//  Created by Alex Rudyak on 5/4/15.
//  Copyright (c) 2015 Alex Rudyak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ITSegment.h"

typedef NS_ENUM(NSInteger, ITSegmentViewAccessory) {
    ITSegmentViewAccessoryNone = 0,
    ITSegmentViewAccessoryArrowUp = 1,
    ITSegmentViewAccessoryArrowDown = 2
};

@interface ITSegmentView : ITSegment

- (instancetype)initWithTitle:(NSString *)title;

@property (copy, nonatomic) NSString *title;

@property (assign, nonatomic) ITSegmentViewAccessory accessory;

- (void)setTitleFont:(UIFont *)font forState:(UIControlState)state;
- (UIFont *)titleFontForState:(UIControlState)state;

- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state;
- (UIColor *)titleColorForState:(UIControlState)state;

@end
