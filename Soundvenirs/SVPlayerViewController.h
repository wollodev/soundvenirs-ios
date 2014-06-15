//
//  SVPlayerTableViewController.h
//  Soundvenir
//
//  Created by Wolfgang Kluth on 14/06/14.
//  Copyright (c) 2014 360degrees. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVCollectedSong.h"

@interface SVPlayerViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) SVCollectedSong *currentSongLocation;

@end
