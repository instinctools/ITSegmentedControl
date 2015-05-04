//
//  UIView+Shapes.m
//  Audi-setmented-control
//
//  Created by Alex Rudyak on 5/4/15.
//  Copyright (c) 2015 Alex Rudyak. All rights reserved.
//

#import "UIView+SegmentShapes.h"

static inline float DegreeToRadians(float degree) {
    return M_PI * degree / 180.f;
}

@implementation UIView (SegmentShapes)

- (UIBezierPath *)trapezePathForSegmentPosition:(ADSegmentPosition)position angle:(CGFloat)angle
{
    CGSize size = self.bounds.size;
    
    if (CGSizeEqualToSize(CGSizeZero, size)) {
        return [UIBezierPath bezierPath];
    }
    
    UIBezierPath *trapezePath = [UIBezierPath bezierPath];
    
    CGFloat offset = size.height * sinf(DegreeToRadians(90 - angle)) / sinf(DegreeToRadians(angle));
    if (angle == 0) {
        offset = 0;
    }
    switch (position) {
        case ADSegmentPositionLeft:
            [trapezePath moveToPoint:CGPointMake(0, size.height)];
            [trapezePath addLineToPoint:CGPointMake(size.width - offset/2, size.height)];
            [trapezePath addLineToPoint:CGPointMake(size.width + offset/2, 0)];
            break;
            
        case ADSegmentPositionCenter:
            [trapezePath moveToPoint:CGPointMake(-offset/2, size.height)];
            [trapezePath addLineToPoint:CGPointMake(size.width - offset/2, size.height)];
            [trapezePath addLineToPoint:CGPointMake(size.width + offset/2, 0)];
            break;
            
        case ADSegmentPositionRight:
            [trapezePath moveToPoint:CGPointMake(-offset/2, size.height)];
            [trapezePath addLineToPoint:CGPointMake(size.width, size.height)];
            [trapezePath addLineToPoint:CGPointMake(size.width, 0)];
            break;
            
        default:
            break;
    }
    
    switch (position) {
        case ADSegmentPositionLeft:
            [trapezePath addLineToPoint:CGPointMake(0, 0)];
            break;
            
        case ADSegmentPositionRight:
            [trapezePath addLineToPoint:CGPointMake(offset/2, 0)];
            break;
            
        case ADSegmentPositionCenter:
            [trapezePath addLineToPoint:CGPointMake(offset/2, 0)];
            break;
            
        default:
            break;
    }
    
    [trapezePath closePath];
    
    return trapezePath;
}

@end
