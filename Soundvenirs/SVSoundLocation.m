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

+ (SVSoundLocation *)soundLocation:(NSNumber *)uuid andTitle:(NSString *)title andLocation:(CLLocationCoordinate2D)location {
    
    SVSoundLocation *soundLocation = [[SVSoundLocation alloc] init];
    
    soundLocation.uuid = uuid;
    soundLocation.title = title;
    soundLocation.location = location;
    
    return soundLocation;
}

@end
