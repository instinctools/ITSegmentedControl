//
//  ADSegmentIndicator.h
//  Audi-setmented-control
//
//  Created by Alex Rudyak on 5/4/15.
//  Copyright (c) 2015 Alex Rudyak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADSegment.h"

@interface ADSegmentIndicator : ADSegment

- (void)setPosition:(ADSegmentPosition)position withFrame:(CGRect)frame animated:(BOOL)animated duration:(NSTimeInterval)duration;

@end
