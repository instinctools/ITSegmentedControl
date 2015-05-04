//
//  ADSegmentView.m
//  Audi-setmented-control
//
//  Created by Alex Rudyak on 5/4/15.
//  Copyright (c) 2015 Alex Rudyak. All rights reserved.
//

#import "ITSegmentView.h"

static CGFloat kMinimumSegmentWidth = 30.f;

@interface ITSegmentView ()

@property (nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) NSMutableDictionary *titleFonts;
@property (strong, nonatomic) NSMutableDictionary *titleColors;

@end

@implementation ITSegmentView

- (instancetype)initWithTitle:(NSString *)title
{
    self = [self initWithFrame:CGRectZero];
    if (self) {
        self.titleLabel.text = title;
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = NO;
        self.titleLabel = [[UILabel alloc] initWithFrame:self.frame];
        self.titleLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:self.titleLabel];
    }
    
    return self;
}

- (NSString *)title
{
    return self.titleLabel.text;
}

- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

- (void)updateState
{
    [super updateState];
    
    self.titleLabel.font = self.titleFonts[@(self.state)];
    self.titleLabel.textColor = self.titleColors[@(self.state)];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGSize sizeThatFits = [self.titleLabel sizeThatFits:size];
    return CGSizeMake(MAX(sizeThatFits.width * 1.4f, kMinimumSegmentWidth), sizeThatFits.height);
}

- (NSMutableDictionary *)titleColors
{
    if (!_titleColors) {
        _titleColors = [NSMutableDictionary dictionary];
        _titleColors[@(UIControlStateNormal)] = [UIColor blackColor];
        _titleColors[@(UIControlStateDisabled)] = [UIColor darkTextColor];
        _titleColors[@(UIControlStateSelected)] = [UIColor blackColor];
        _titleColors[@(UIControlStateHighlighted)] = [UIColor blackColor];
    }
    return _titleColors;
}

- (NSMutableDictionary *)titleFonts
{
    if (!_titleFonts) {
        _titleFonts = [NSMutableDictionary dictionary];
        _titleFonts[@(UIControlStateNormal)] = [UIFont systemFontOfSize:13];
        _titleFonts[@(UIControlStateDisabled)] = [UIFont systemFontOfSize:13];
        _titleFonts[@(UIControlStateSelected)] = [UIFont boldSystemFontOfSize:13];
        _titleFonts[@(UIControlStateHighlighted)] = [UIFont systemFontOfSize:13];
    }
    return _titleFonts;
}

- (UIFont *)titleFontForState:(UIControlState)state
{
    return self.titleFonts[@(state)];
}

- (void)setTitleFont:(UIFont *)font forState:(UIControlState)state
{
    if (font) {
        self.titleFonts[@(state)] = font;
        [self setNeedsDisplay];
    }
}

- (UIColor *)titleColorForState:(UIControlState)state
{
    return self.titleColors[@(state)];
}

- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state
{
    if (color) {
        self.titleColors[@(state)] = color;
        [self setNeedsDisplay];
    }
}

@end
