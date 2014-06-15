//
//  SVCollectedSong.h
//  Soundvenir
//
//  Created by Wolfgang Kluth on 10/06/14.
//  Copyright (c) 2014 360degrees. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface SVCollectedSong : NSObject

@property NSNumber *uuid;
@property NSString *title;
@property CLLocationCoordinate2D location;
@property NSString *songUrl;

+ (SVCollectedSong *)collectedSong:(NSNumber *)uuid andTitle:(NSString *)title andLocation:(CLLocationCoordinate2D)location songUrl:(NSString *)songUrl;

@end
