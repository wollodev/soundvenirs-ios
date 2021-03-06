//
//  SVAppDelegate.h
//  Soundvenir
//
//  Created by Wolfgang Kluth on 02/06/14.
//  Copyright (c) 2014 360degrees. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface SVAppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSMutableArray *collectedSongs;
@property (strong, nonatomic) CLLocation *ownLocation;
@property (strong, nonatomic) CLLocationManager *locationManager;

@end
