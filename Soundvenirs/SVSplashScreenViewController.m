//
//  SVSplashScreenViewController.m
//  Soundvenirs
//
//  Created by Wolfgang Kluth on 17/07/14.
//  Copyright (c) 2014 360degrees. All rights reserved.
//

#import "SVSplashScreenViewController.h"

@interface SVSplashScreenViewController ()

- (void)dismissSplashScreen;

@end

@implementation SVSplashScreenViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self performSelector:@selector(dismissSplashScreen) withObject:nil afterDelay:1.5];
}


- (void)dismissSplashScreen {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
