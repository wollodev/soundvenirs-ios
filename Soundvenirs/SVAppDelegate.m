//
//  SVAppDelegate.m
//  Soundvenir
//
//  Created by Wolfgang Kluth on 02/06/14.
//  Copyright (c) 2014 360degrees. All rights reserved.
//

#import "SVAppDelegate.h"
#import "SVCollectedSong.h"

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@interface SVAppDelegate ()

- (void)openMenu;

@end

@implementation SVAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    //Here you set the Distance Filter that you need
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    // Here you set the Accuracy
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    [self.locationManager startUpdatingLocation];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *savedSongs = [defaults objectForKey:@"collectedSongs"];
    
    self.collectedSongs = [NSMutableArray array];
    
    for (NSDictionary *songDict in savedSongs) {
        CLLocationCoordinate2D location = CLLocationCoordinate2DMake([songDict[@"lat"] doubleValue], [songDict[@"long"] doubleValue]);
        SVCollectedSong *savedCollectedSong = [SVCollectedSong collectedSong:songDict[@"uuid"] andTitle:songDict[@"title"] andLocation:location songUrl:songDict[@"songUrl"]];
        [self.collectedSongs addObject:savedCollectedSong];
    }
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    if (IS_IPHONE_5) {
        self.window.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"splash_screen_5.png"]];
    } else {
        self.window.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"splash_screen_4.png"]];
    }
    
    [self.window makeKeyAndVisible];
    
    [self performSelector:@selector(openMenu) withObject:nil afterDelay:1.5];
    
    return YES;
}

- (void)openMenu {
    self.window.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_1.jpg"]];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *viewController = (UIViewController *)[storyboard instantiateViewControllerWithIdentifier:@"Menu"];

    self.window.rootViewController = viewController;
    
//    [self.window makeKeyAndVisible];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    self.ownLocation = [locations lastObject];
    [self.locationManager stopMonitoringSignificantLocationChanges];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    NSMutableArray *tmpSongs = [NSMutableArray array];
    
    for (SVCollectedSong *tmpSong in self.collectedSongs) {
        [tmpSongs addObject:tmpSong.convertToDictionary];
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:tmpSongs forKey:@"collectedSongs"];

    self.window.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background_2.jpg"]];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
