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

- (IBAction)openMap:(id)sender;
- (IBAction)openScanner:(id)sender;
- (IBAction)openPlayer:(id)sender;
- (IBAction)openLocationScanner:(id)sender;

@end

@implementation SVMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
//    // make navigation bar transparent
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
//                             forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.shadowImage = [UIImage new];
//    self.navigationController.navigationBar.translucent = YES;
//    self.navigationController.view.backgroundColor = [UIColor clearColor];
//    
//    
//    // add back-button image to navigation
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
//    self.navigationController.navigationBar.backIndicatorImage = [UIImage imageNamed:@"back_button.png"];
//    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"back_button.png"];
//    
//    // set back-button color
//    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.15 green:0.32 blue:0.46 alpha:0.8];
//    
    // set main-menu background to transparent
    self.view.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)presentDetailController:(UIViewController*)detailVC{
    
    //0. Remove the current Detail View Controller showed
    if(self.currentDetailViewController){
        [self removeCurrentDetailViewController];
    }
    
    //1. Add the detail controller as child of the container
    [self addChildViewController:detailVC];
    
    //2. Define the detail controller's view size
    detailVC.view.frame = [self frameForDetailController];
    
    //3. Add the Detail controller's view to the Container's detail view and save a reference to the detail View Controller
    [self.detailView addSubview:detailVC.view];
    self.currentDetailViewController = detailVC;
    
    //4. Complete the add flow calling the function didMoveToParentViewController
    [detailVC didMoveToParentViewController:self];
    
    self.controlContainer.hidden = YES;
    self.detailView.hidden = NO;
    
}

- (void)removeCurrentDetailViewController{
    
    //1. Call the willMoveToParentViewController with nil
    //   This is the last method where your detailViewController can perform some operations before neing removed
    [self.currentDetailViewController willMoveToParentViewController:nil];
    
    //2. Remove the DetailViewController's view from the Container
    [self.currentDetailViewController.view removeFromSuperview];
    
    //3. Update the hierarchy"
    //   Automatically the method didMoveToParentViewController: will be called on the detailViewController)
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

- (IBAction)openMap:(id)sender {
    [self openViewController:@"Map"];
}

- (IBAction)openScanner:(id)sender {
    [self openViewController:@"Scanner"];
}

- (IBAction)openPlayer:(id)sender {
    [self openViewController:@"Player"];
}

- (IBAction)openLocationScanner:(id)sender {
    [self openViewController:@"LocationScanner"];
}
@end
