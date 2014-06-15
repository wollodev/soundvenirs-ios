//
//  SVSoundLocation.m
//  Soundvenir
//
//  Created by Wolfgang Kluth on 10/06/14.
//  Copyright (c) 2014 360degrees. All rights reserved.
//
// http://www.soundvenirs.com/api/soundLocations
//{
//    "title": "The Sound of Silence",
//    "location": {
//        "lat": 51.394747,
//        "long": 6.494785
//    },
//}

#import "SVSoundLocation.h"
#import <AFNetworking/AFNetworking.h>

@implementation SVSoundLocation

+ (SVSoundLocation *)soundLocation:(NSString *)title andLocation:(CLLocationCoordinate2D)location {
    
    SVSoundLocation *soundLocation = [[SVSoundLocation alloc] init];
    
    soundLocation.title = title;
    soundLocation.location = location;
    
    return soundLocation;
}

+ (NSArray *)soundLocationDump {
    return @[[SVSoundLocation soundLocation:@"Test1" andLocation:CLLocationCoordinate2DMake(50.780103, 6.060604)],
             [SVSoundLocation soundLocation:@"Test2" andLocation:CLLocationCoordinate2DMake(50.764340, 6.103681)]];
}

+ (NSArray *)requestAllSoundLocations {
    NSMutableArray *soundLocations = nil;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://www.soundvenirs.com/api/soundLocations" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        for (NSDictionary *soundLocationDict in responseObject) {
            NSDictionary *locationDict = soundLocationDict[@"location"];
            CLLocationCoordinate2D location = CLLocationCoordinate2DMake([locationDict[@"lat"] doubleValue], [locationDict[@"long"] doubleValue]);
            
            SVSoundLocation *newSoundLocation =[SVSoundLocation soundLocation:soundLocationDict[@"title"] andLocation:location];
            
            [soundLocations addObject:newSoundLocation];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"ERROR: %@", error);
    }];
    
    return [NSArray arrayWithArray:soundLocations];
}

@end
