//
//  ADSegmentedControl.h
//  Audi-setmented-control
//
//  Created by Alex Rudyak on 5/2/15.
//  Copyright (c) 2015 Alex Rudyak. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ITSegmentedControlDelegate;

@interface ITSegmentedControl : UIControl

@property (weak, nonatomic) NSObject<ITSegmentedControlDelegate> *delegate;

@property (assign, nonatomic, readonly) NSUInteger selectedIndex;

- (instancetype)initWithTitles:(NSArray *)titles;

@property (assign, nonatomic) CGFloat borderAngle;

@property (nonatomic) UIFont *titleFont UI_APPEARANCE_SELECTOR;

/**
 The color of the segment titles
 */
@property (nonatomic) UIColor *titleTextColor UI_APPEARANCE_SELECTOR;

/**
 The font used for the selected segment's title
 */
@property (nonatomic) UIFont *selectedTitleFont UI_APPEARANCE_SELECTOR;

/**
 The color of the selected segment's title
 */
@property (nonatomic) UIColor *selectedTitleTextColor UI_APPEARANCE_SELECTOR;

/**
 The font used for the selected segment's title
 */
@property (nonatomic) UIFont *disabledTitleFont UI_APPEARANCE_SELECTOR;

/**
 The color of the selected segment's title
 */
@property (nonatomic) UIColor *disabledTitleTextColor UI_APPEARANCE_SELECTOR;

/**
 If `YES`, then use CAGradientLayer to draw control backgound. Default `NO`
 */
@property (nonatomic) BOOL useGradientBackground UI_APPEARANCE_SELECTOR;

/**
 The start (top) color of the control's background gradient.
 
 @see drawsGradientBackground
 */
@property (nonatomic) UIColor *gradientTopColor UI_APPEARANCE_SELECTOR;

/**
 The end (bottom) color of the control's background gradient.
 
 @see drawsGradientBackground
 */
@property (nonatomic) UIColor *gradientBottomColor UI_APPEARANCE_SELECTOR;

/**
 The duration of the segment change animation.
 */
@property (nonatomic) CGFloat segmentIndicatorAnimationDuration UI_APPEARANCE_SELECTOR;

@property (nonatomic) UIColor *selectionColor UI_APPEARANCE_SELECTOR;

@property (nonatomic) UIColor *disabledColor UI_APPEARANCE_SELECTOR;

- (void)setTitle:(NSString *)title forSegmentAtIndex:(NSUInteger)index;
- (NSString *)titleForSegmentAtIndex:(NSUInteger)index;

- (void)setSizeThatFitsForSegmentAtIndex:(NSUInteger)index;

- (void)setEnabled:(BOOL)enabled forSegmentAtIndex:(NSUInteger)index;
- (BOOL)isEnabledForSegmentAtIndex:(NSUInteger)index;

- (void)setSegmentSelectedAtIndex:(NSUInteger)index animated:(BOOL)animated;

- (void)insertSegmentWithTitle:(NSString *)title atIndex:(NSUInteger)index animated:(BOOL)animated;

- (void)removeSegmentWithIndex:(NSUInteger)index animated:(BOOL)animated;

- (void)removeAllSegments;

@end

@protocol ITSegmentedControlDelegate <NSObject>

@end
