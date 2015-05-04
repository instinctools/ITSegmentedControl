//
//  ADSegmentIndicator.m
//  Audi-setmented-control
//
//  Created by Alex Rudyak on 5/4/15.
//  Copyright (c) 2015 Alex Rudyak. All rights reserved.
//

#import "ADSegmentIndicator.h"
#import "UIView+SegmentShapes.h"
#import <QuartzCore/QuartzCore.h>

@implementation ADSegmentIndicator

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self _initialize];
    }
    return self;
}

- (void)_initialize
{
    [self setUserInteractionEnabled:NO];
    [self setBackgroundColor:[UIColor redColor] forState:UIControlStateNormal];
}

- (void)setPosition:(ADSegmentPosition)position withFrame:(CGRect)frame animated:(BOOL)animated duration:(NSTimeInterval)duration
{
    if (animated) {
        UIBezierPath *newPath = [self trapezePathForSegmentPosition:position angle:self.angle];
        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
        pathAnimation.duration = duration;
        pathAnimation.toValue = (id)[newPath CGPath];
        [self.layer addAnimation:pathAnimation forKey:@"pathAnimation"];
        
        [UIView animateWithDuration:duration delay:.0f options:UIViewAnimationOptionCurveLinear animations:^{
            self.frame = frame;
        } completion:^(BOOL finished) {
            if (finished) {
                self.segmentPosition = position;
            }
        }];
    } else {
        self.frame = frame;
        self.segmentPosition = position;
    }
}

@end
