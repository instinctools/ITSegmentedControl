//
//  ADSegment.h
//  Audi-setmented-control
//
//  Created by Alex Rudyak on 5/4/15.
//  Copyright (c) 2015 Alex Rudyak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+SegmentShapes.h"

@interface ITSegment : UIControl

@property (assign, nonatomic) CGFloat angle;

@property (assign, nonatomic) ADSegmentPosition segmentPosition;

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state;
- (UIColor *)backgroundColorForState:(UIControlState)state;

- (void)updateState;

- (UIBezierPath *)shapePath;

- (CGRect)mostWidestRect;

@end
