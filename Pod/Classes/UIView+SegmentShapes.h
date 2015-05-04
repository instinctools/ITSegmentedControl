//
//  UIView+Shapes.h
//  Audi-setmented-control
//
//  Created by Alex Rudyak on 5/4/15.
//  Copyright (c) 2015 Alex Rudyak. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ADSegmentPosition) {
    ADSegmentPositionLeft,
    ADSegmentPositionRight,
    ADSegmentPositionCenter
};

@interface UIView (SegmentShapes)

- (UIBezierPath *)trapezePathForSegmentPosition:(ADSegmentPosition)position angle:(CGFloat)angle;

@end
