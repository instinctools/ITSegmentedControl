//
//  ADSegment.m
//  Audi-setmented-control
//
//  Created by Alex Rudyak on 5/4/15.
//  Copyright (c) 2015 Alex Rudyak. All rights reserved.
//

#import "ITSegment.h"

@interface ITSegment ()

@property (strong, nonatomic) NSMutableDictionary *backgroundColors;

@end

@implementation ITSegment

+ (Class)layerClass
{
    return [CAShapeLayer class];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self layoutSegment];
    [self updateState];
}

- (UIBezierPath *)shapePath
{
    return [(CAShapeLayer *)self.layer path];
}

- (void)setSegmentPosition:(ADSegmentPosition)segmentPosition
{
    _segmentPosition = segmentPosition;
    
    [self setNeedsLayout];
}

- (void)layoutSegment
{
    UIBezierPath *path = [self trapezePathForSegmentPosition:self.segmentPosition angle:self.angle];
    [(CAShapeLayer *)self.layer setPath:[path CGPath]];
}

- (UIColor *)backgroundColor
{
    return [UIColor colorWithCGColor:[(CAShapeLayer *)self.layer fillColor]];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [(CAShapeLayer *)self.layer setFillColor:[backgroundColor CGColor]];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state
{
    if (backgroundColor) {
        self.backgroundColors[@(state)] = backgroundColor;
        [self setNeedsDisplay];
    }
}

- (UIColor *)backgroundColorForState:(UIControlState)state
{
    return self.backgroundColors[@(state)];
}

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    [self updateState];
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    
    [self updateState];
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    
    [self updateState];
}

- (void)updateState
{
    self.backgroundColor = self.backgroundColors[@(self.state)];
}

- (NSMutableDictionary *)backgroundColors
{
    if (!_backgroundColors) {
        _backgroundColors = [NSMutableDictionary dictionary];
        _backgroundColors[@(UIControlStateNormal)] = [UIColor clearColor];
        _backgroundColors[@(UIControlStateDisabled)] = [UIColor clearColor];
        _backgroundColors[@(UIControlStateSelected)] = [UIColor clearColor];
        _backgroundColors[@(UIControlStateHighlighted)] = [UIColor clearColor];
    }
    return _backgroundColors;
}

@end
