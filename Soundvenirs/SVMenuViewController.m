//
//  SVViewController.m
//  Soundvenir
//
//  Created by Wolfgang Kluth on 02/06/14.
//  Copyright (c) 2014 360degrees. All rights reserved.
//

#import "SVMenuViewController.h"
#import "SVMapViewController.h"

@interface SVMenuViewController ()

@property UIViewController  *currentDetailViewController;
@property (weak, nonatomic) IBOutlet UIView *controlContainer;

- (IBAction)openMenu:(id)sender;

@end

@implementation SVMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)presentDetailController:(UIViewController*)detailVC {
    
    if(self.currentDetailViewController){
        [self removeCurrentDetailViewController];
    }
    
    [self addChildViewController:detailVC];
    
    detailVC.view.frame = [self frameForDetailController];
    
    [self.detailView addSubview:detailVC.view];
    self.currentDetailViewController = detailVC;
    
    [detailVC didMoveToParentViewController:self];
    
    self.controlContainer.hidden = YES;
    self.detailView.hidden = NO;
    
}

- (void)removeCurrentDetailViewController{
    
    [self.currentDetailViewController willMoveToParentViewController:nil];
    
    [self.currentDetailViewController.view removeFromSuperview];
    
    [self.currentDetailViewController removeFromParentViewController];
    
    self.detailView.hidden = YES;
    self.controlContainer.hidden = NO;
}

- (CGRect)frameForDetailController{
    CGRect detailFrame = self.detailView.bounds;
    
    return detailFrame;
}

- (void)openViewController:(NSString *)identifier {
    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    
    [self presentDetailController:viewController];
}

- (IBAction)openMenu:(id)sender {
    [self removeCurrentDetailViewController];
}


@end
