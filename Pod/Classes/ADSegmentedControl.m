//
//  ADSegmentedControl.m
//  Audi-setmented-control
//
//  Created by Alex Rudyak on 5/2/15.
//  Copyright (c) 2015 Alex Rudyak. All rights reserved.
//

#import "ADSegmentedControl.h"
#import "ADSegmentView.h"
#import "ADSegmentIndicator.h"

@interface ADSegmentedControl ()

@property (assign, nonatomic, readwrite) NSUInteger selectedIndex;

@property (strong, nonatomic) NSArray *items;
@property (strong, nonatomic) NSArray *segments;
@property (strong, nonatomic) ADSegmentIndicator *selectionIndicator;

@property (strong, nonatomic) NSMutableSet *fitsSegments;

@end

@implementation ADSegmentedControl

+ (Class)layerClass
{
    return [CAGradientLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initialize];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self _initialize];
    }
    
    return self;
}

- (instancetype)initWithTitles:(NSArray *)titles
{
    self = [super init];
    if (self) {
        self.items = titles;
    }
    
    self.fitsSegments = [NSMutableSet set];
    NSMutableArray *segments = [NSMutableArray arrayWithCapacity:[self.items count]];
    [self.items enumerateObjectsUsingBlock:^(NSString *title, NSUInteger idx, BOOL *stop) {
        ADSegmentView *segmentView = [[ADSegmentView alloc] initWithTitle:title];
        segmentView.angle = self.borderAngle;
        segmentView.segmentPosition = [self positionForSegmentAtIndex:idx];
        segmentView.frame = CGRectZero;

        [segments addObject:segmentView];
        [self addSubview:segmentView];
    }];
    self.segments = segments;
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognized:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [self addGestureRecognizer:tapGestureRecognizer];

    return self;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    if (self.useGradientBackground) {
        self.layer.backgroundColor = [UIColor clearColor].CGColor;
        [(CAGradientLayer *)self.layer setColors:@[
                                                   (id)self.gradientTopColor.CGColor,
                                                   (id)self.gradientBottomColor.CGColor
                                                   ]];
    } else {
        self.layer.backgroundColor = self.backgroundColor.CGColor;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSMutableDictionary *sizedWidths = [NSMutableDictionary dictionaryWithCapacity:[self.fitsSegments count]];
    CGFloat __block totalSizedWidth = 0;
    [self.fitsSegments enumerateObjectsUsingBlock:^(NSNumber *obj, BOOL *stop) {
        CGSize size = [self.segments[obj.integerValue] frame].size;
        sizedWidths[obj] = @(size.width);
        totalSizedWidth += size.width;
    }];
    
    CGFloat segmentWidth = (CGRectGetWidth(self.frame) - totalSizedWidth) / ([self.segments count] - [self.fitsSegments count]);
    CGFloat segmentHeight = CGRectGetHeight(self.frame);
    CGRect __block lastFrame = CGRectZero;
    [self.segments enumerateObjectsUsingBlock:^(ADSegmentView *segment, NSUInteger idx, BOOL *stop) {
        segment.angle = self.borderAngle;
        CGFloat updatedSegmentWidth = [self.fitsSegments containsObject:@(idx)] ? [sizedWidths[@(idx)] floatValue] : segmentWidth;
        segment.frame = CGRectMake(lastFrame.origin.x + lastFrame.size.width, .0f, updatedSegmentWidth, segmentHeight);
        [segment setTitleFont:self.titleFont forState:UIControlStateNormal];
        [segment setTitleFont:self.selectedTitleFont forState:UIControlStateSelected];
        [segment setTitleFont:self.disabledTitleFont forState:UIControlStateDisabled];
        [segment setTitleColor:self.titleTextColor forState:UIControlStateNormal];
        [segment setTitleColor:self.selectedTitleTextColor forState:UIControlStateSelected];
        [segment setTitleColor:self.disabledTitleTextColor forState:UIControlStateDisabled];
        [segment setBackgroundColor:[UIColor clearColor] forState:UIControlStateNormal];
        [segment setBackgroundColor:self.disabledColor forState:UIControlStateDisabled];
        lastFrame = segment.frame;
    }];

    self.selectionIndicator.angle = self.borderAngle;
    [self.selectionIndicator setBackgroundColor:self.selectionColor forState:UIControlStateNormal];
    if (self.selectedIndex != NSNotFound) {
        [self.selectionIndicator setPosition:[self positionForSegmentAtIndex:self.selectedIndex] withFrame:[self indicatorFrameForSegment:self.segments[self.selectedIndex]] animated:NO duration:self.segmentIndicatorAnimationDuration];
    }
}

- (void)_initialize
{
    _titleFont = [UIFont systemFontOfSize:13.0f];
    _titleTextColor = [UIColor blackColor];
    _selectedTitleFont = [UIFont boldSystemFontOfSize:13.0f];
    _selectedTitleTextColor = [UIColor blackColor];
    _segmentIndicatorAnimationDuration = 0.15f;
    _gradientTopColor = [UIColor colorWithRed:0.21f green:0.21f blue:0.21f alpha:1.0f];
    _gradientBottomColor = [UIColor colorWithRed:0.16f green:0.16f blue:0.16f alpha:1.0f];
    _selectionColor = [UIColor redColor];
    _disabledColor = [UIColor darkGrayColor];
    
    self.opaque = NO;
    self.backgroundColor = [UIColor clearColor];
    
    self.selectionIndicator = [[ADSegmentIndicator alloc] initWithFrame:CGRectZero];
    self.selectionIndicator.angle = self.borderAngle;
    [self addSubview:self.selectionIndicator];
    
    self.selectedIndex = NSNotFound;
}

- (void)setTitle:(NSString *)title forSegmentAtIndex:(NSUInteger)index
{
    ADSegmentView *segment = self.segments[index];
    segment.title = title;
}

- (NSString *)titleForSegmentAtIndex:(NSUInteger)index
{
    return self.items[index];
}

- (void)setSizeThatFitsForSegmentAtIndex:(NSUInteger)index
{
    ADSegmentView *segment = self.segments[index];
    [segment sizeToFit];
    [self.fitsSegments addObject:@(index)];
}

- (void)setEnabled:(BOOL)enabled forSegmentAtIndex:(NSUInteger)index
{
    ADSegmentView *segment = self.segments[index];
    segment.enabled = enabled;
}

- (BOOL)isEnabledForSegmentAtIndex:(NSUInteger)index
{
    ADSegmentView *segment = self.segments[index];
    return segment.isEnabled;
}

- (void)setSegmentSelectedAtIndex:(NSUInteger)index animated:(BOOL)animated
{
    if (index >= [self.segments count]) {
        index = [self.segments count] - 1;
    }
    
    [self handleSegmentSelection:self.segments[index] animated:animated];
}

- (void)handleSegmentSelection:(ADSegmentView *)sender animated:(BOOL)animated
{
    NSUInteger index = [self.segments indexOfObjectIdenticalTo:sender];
    if (index != NSNotFound && self.selectedIndex != index && sender.isEnabled) {        
        [self moveSelectedSegmentIndicatorToSegmentAtIndex:index animated:animated];
        self.selectedIndex = index;
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}

- (void)moveSelectedSegmentIndicatorToSegmentAtIndex:(NSUInteger)index animated:(BOOL)animated
{
    ADSegmentView *selectedSegment = self.segments[index];
    [self.selectionIndicator setPosition:[self positionForSegmentAtIndex:index] withFrame:[self indicatorFrameForSegment:selectedSegment] animated:animated duration:self.segmentIndicatorAnimationDuration];
}

- (CGRect)indicatorFrameForSegment:(ADSegmentView *)segment {
    return segment.frame;
}

- (void)tapGestureRecognized:(UITapGestureRecognizer *)recognizer
{
    CGPoint location = [recognizer locationInView:self];
    [self.segments enumerateObjectsUsingBlock:^(ADSegmentView *segment, NSUInteger index, BOOL *stop) {
        if (CGRectContainsPoint(segment.frame, location)) {
            if (index != self.selectedIndex) {
                [self handleSegmentSelection:segment animated:YES];
                *stop = YES;
            }
        }
    }];
}

- (ADSegmentPosition)positionForSegmentAtIndex:(NSUInteger)index
{
    return index == 0  ? ADSegmentPositionLeft : (index >= [self.items count] - 1 ? ADSegmentPositionRight : ADSegmentPositionCenter);
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    if (!self.useGradientBackground) {
        self.layer.backgroundColor = backgroundColor.CGColor;
    }
}

- (void)setTitleFont:(UIFont *)titleFont
{
    _titleFont = titleFont;
    [self setNeedsLayout];
}

- (void)setTitleTextColor:(UIColor *)titleTextColor
{
    _titleTextColor = titleTextColor;
    [self setNeedsLayout];
}

- (void)setSelectedTitleFont:(UIFont *)selectedTitleFont
{
    _selectedTitleFont = selectedTitleFont;
    [self setNeedsLayout];
}

- (void)setSelectedTitleTextColor:(UIColor *)selectedTitleTextColor
{
    _selectedTitleTextColor = selectedTitleTextColor;
    [self setNeedsLayout];
}

- (void)setDisabledTitleFont:(UIFont *)disabledTitleFont
{
    _disabledTitleFont = disabledTitleFont;
    [self setNeedsLayout];
}

- (void)setDisabledTitleTextColor:(UIColor *)disabledTitleTextColor
{
    _disabledTitleTextColor = disabledTitleTextColor;
    [self setNeedsLayout];
}

- (void)setUseGradientBackground:(BOOL)useGradientBackground
{
    _useGradientBackground = useGradientBackground;
    [self setNeedsDisplay];
}

- (void)setGradientTopColor:(UIColor *)gradientTopColor
{
    _gradientTopColor = gradientTopColor;
    
    if (self.useGradientBackground) {
        [self setNeedsDisplay];
    }
}

- (void)setGradientBottomColor:(UIColor *)gradientBottomColor
{
    _gradientBottomColor = gradientBottomColor;
    
    if (self.useGradientBackground) {
        [self setNeedsDisplay];
    }
}

- (void)setSelectionColor:(UIColor *)selectionColor
{
    _selectionColor = selectionColor;
    [self setNeedsLayout];
}

- (void)setDisabledColor:(UIColor *)disabledColor
{
    _disabledColor = disabledColor;
    [self setNeedsLayout];
}

@end
