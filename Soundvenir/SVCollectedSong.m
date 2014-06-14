//
//  SVCollectedSong.m
//  Soundvenir
//
//  Created by Wolfgang Kluth on 10/06/14.
//  Copyright (c) 2014 360degrees. All rights reserved.
//

#import "SVCollectedSong.h"

@implementation SVCollectedSong

+ (SVCollectedSong *)collectedSong:(NSString *)title andLocation:(CLLocationCoordinate2D)location songUrl:(NSURL *)songUrl {
    
    SVCollectedSong *collectedSong = [[SVCollectedSong alloc] init];
    
    collectedSong.title = title;
    collectedSong.location = location;
    collectedSong.songUrl = songUrl;
    
    return collectedSong;
}

@end
