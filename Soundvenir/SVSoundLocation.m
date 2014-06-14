//
//  SVSoundLocation.m
//  Soundvenir
//
//  Created by Wolfgang Kluth on 10/06/14.
//  Copyright (c) 2014 360degrees. All rights reserved.
//

#import "SVSoundLocation.h"

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

@end
