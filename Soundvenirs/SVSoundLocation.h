//
//  SVSoundLocation.h
//  Soundvenir
//
//  Created by Wolfgang Kluth on 10/06/14.
//  Copyright (c) 2014 360degrees. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface SVSoundLocation : NSObject

@property NSNumber *uuid;
@property NSString *title;
@property CLLocationCoordinate2D location;

+ (SVSoundLocation *)soundLocation:(NSNumber *)uuid andTitle:(NSString *)title andLocation:(CLLocationCoordinate2D)location;

@end
