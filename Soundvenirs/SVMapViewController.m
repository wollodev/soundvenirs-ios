//
//  SVMapViewController.m
//  Soundvenir
//
//  Created by Wolfgang Kluth on 10/06/14.
//  Copyright (c) 2014 360degrees. All rights reserved.
//

#import "SVMapViewController.h"
#import <MapKit/MapKit.h>
#import "SVSoundLocation.h"

@interface SVMapViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) NSArray *soundLocations;

@end

@implementation SVMapViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    self.soundLocations = [SVSoundLocation soundLocationDump];
    self.view.backgroundColor = [UIColor clearColor];
    
    self.mapView.hidden = YES;
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
    self.navigationController.navigationBar.backIndicatorImage = [UIImage imageNamed:@"back_button.png"];
    self.navigationController.navigationBar.backIndicatorTransitionMaskImage = [UIImage imageNamed:@"back_button.png"];

}

- (void)viewDidAppear:(BOOL)animated {
    for (SVSoundLocation *soundLocation in self.soundLocations) {
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        annotation.coordinate = soundLocation.location;
        annotation.title = soundLocation.title;
        
        [self.mapView addAnnotation:annotation];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - Map

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    MKCoordinateRegion mapRegion;
    mapRegion.center = mapView.userLocation.coordinate;
    mapRegion.span = MKCoordinateSpanMake(0.2, 0.2);
    [mapView setRegion:mapRegion animated: NO];
    
    self.mapView.hidden = NO;
}

//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
//{
//    // If it's the user location, just return nil.
//    if ([annotation isKindOfClass:[MKUserLocation class]])
//        return nil;
//    
//    // Handle any custom annotations.
//    if ([annotation isKindOfClass:[MKPointAnnotation class]])
//    {
//        // Try to dequeue an existing pin view first.
//        MKAnnotationView* pinView = (MKAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:@"PinAnnotationView"];
//        
//        if (!pinView)
//        {
//            // If an existing pin view is not available, create one.
//            pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"PinAnnotationView"];
//            //pinView.image = [UIImage imageNamed:@"bike-icon.png"];
//            pinView.canShowCallout = YES;
//            //pinView.centerOffset = CGPointMake(0, -18);
//        }
//        else
//        {
//            pinView.annotation = annotation;
//            //pinView.image = [UIImage imageNamed:@"bike-icon.png"];
//        }
//        
//        return pinView;
//    }
//    
//    return nil;
//}

//- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
//{
//    MKPointAnnotation *annotation = view.annotation;
//    
//    // If it's the user location, just return nil.
//    if ([annotation isKindOfClass:[MKUserLocation class]])
//        return;
//    
//    NSInteger tableRow = [annotation.title integerValue];
//    
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:tableRow inSection:0];
//    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
//    [self tableView:self.tableView didDeselectRowAtIndexPath:self.lastSelectedCell];
//    [self.mapView deselectAnnotation:annotation animated:NO];
//    [self tableView:self.tableView didSelectRowAtIndexPath:indexPath];
//}



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