//
//  SVPlayerTableViewController.m
//  Soundvenir
//
//  Created by Wolfgang Kluth on 14/06/14.
//  Copyright (c) 2014 360degrees. All rights reserved.
//

#import "SVPlayerViewController.h"
#import "SVAppDelegate.h"
#import <AFSoundManager/AFSoundManager.h>

@interface SVPlayerViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *fixedTableFooterView;
@property (strong, nonatomic) NSArray *collectedSongs;

@end

@implementation SVPlayerViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor clearColor];

    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    
    self.tableView.tableHeaderView = nil;
    
    SVAppDelegate *appDelegate = (SVAppDelegate *)[UIApplication sharedApplication].delegate;
    self.collectedSongs = [NSArray arrayWithArray:appDelegate.collectedSongs];
    
    if (self.currentSongLocation) {
        [[AFSoundManager sharedManager] startStreamingRemoteAudioFromURL:self.currentSongLocation.songUrl andBlock:^(int percentage, CGFloat elapsedTime, CGFloat timeRemaining, NSError *error, BOOL finished) {
        }];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.collectedSongs count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SongCell" forIndexPath:indexPath];
 
    UILabel *titleLabel = (UILabel *)[cell viewWithTag:11];
    
    SVCollectedSong *collectedSong = [self.collectedSongs objectAtIndex:indexPath.row];
    
    titleLabel.text = collectedSong.title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SVCollectedSong *collectedSong = [self.collectedSongs objectAtIndex:indexPath.row];
    
    [[AFSoundManager sharedManager] startStreamingRemoteAudioFromURL:collectedSong.songUrl andBlock:^(int percentage, CGFloat elapsedTime, CGFloat timeRemaining, NSError *error, BOOL finished) {
        
    }];
}
- (IBAction)play:(id)sender {
    [[AFSoundManager sharedManager] resume];
}
- (IBAction)stop:(id)sender {
    [[AFSoundManager sharedManager] pause];
}
@end
