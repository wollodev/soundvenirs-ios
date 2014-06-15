//
//  SVViewController.m
//  Soundvenir
//
//  Created by Wolfgang Kluth on 02/06/14.
//  Copyright (c) 2014 360degrees. All rights reserved.
//

#import "SVMenuViewController.h"

@interface SVMenuViewController ()

@end

@implementation SVMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // make navigation bar transparent
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                             forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
    
    
    // add back-button image to navigation
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
    self.navigationController.navigationBar.backIndicatorImage = [UIImage imageNamed:@"back_button.png"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"back_button.png"];
    
    // set back-button color
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.15 green:0.32 blue:0.46 alpha:0.8];
    
    // set main-menu background to transparent
    self.view.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
