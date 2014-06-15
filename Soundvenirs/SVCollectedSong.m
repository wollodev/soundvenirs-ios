//
//  SVCollectedSong.m
//  Soundvenir
//
//  Created by Wolfgang Kluth on 10/06/14.
//  Copyright (c) 2014 360degrees. All rights reserved.
//

#import "SVCollectedSong.h"

@implementation SVCollectedSong

+ (SVCollectedSong *)collectedSong:(NSNumber *)uuid andTitle:(NSString *)title andLocation:(CLLocationCoordinate2D)location songUrl:(NSString *)songUrl {
    
    SVCollectedSong *collectedSong = [[SVCollectedSong alloc] init];
    
    collectedSong.uuid = uuid;
    collectedSong.title = title;
    collectedSong.location = location;
    collectedSong.songUrl = songUrl;
    
    return collectedSong;
}

- (NSDictionary *)convertToDictionary {
    return @{@"uuid": self.uuid, @"title":self.title, @"lat":[NSNumber numberWithDouble:self.location.latitude], @"long":[NSNumber numberWithDouble:self.location.longitude], @"songUrl":self.songUrl};
}

@end
