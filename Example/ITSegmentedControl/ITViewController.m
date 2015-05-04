//
//  ITViewController.m
//  ITSegmentedControl
//
//  Created by Alex Rudyak on 05/04/2015.
//  Copyright (c) 2014 Alex Rudyak. All rights reserved.
//

#import "ITViewController.h"
#import "ITSegmentedControl.h"

@interface ITViewController ()

@property (weak, nonatomic) IBOutlet UIView *segmentHolderView;

@end

@implementation ITViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    ITSegmentedControl *segmentedControl = [[ITSegmentedControl alloc] initWithTitles:@[@"One", @"Two"]];
    segmentedControl.backgroundColor = [UIColor grayColor];
    segmentedControl.borderAngle = 75;
    segmentedControl.gradientTopColor = [UIColor colorWithRed:236 / 255.f green:236 / 255.f blue:236 / 255.f alpha:1.f];
    segmentedControl.gradientBottomColor = [UIColor colorWithRed:212 / 255.f green:212 / 255.f blue:212 / 255.f alpha:1.f];
    segmentedControl.useGradientBackground = YES;
    [segmentedControl setSegmentSelectedAtIndex:1 animated:YES];
    [segmentedControl addTarget:self action:@selector(segmentSelectionChanged:) forControlEvents:UIControlEventValueChanged];
    [self.segmentHolderView addSubview:segmentedControl];
    segmentedControl.frame = self.segmentHolderView.bounds;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)segmentSelectionChanged:(ITSegmentedControl *)sender
{
    NSLog(@"Selected: %ld", sender.selectedIndex);
}

@end
