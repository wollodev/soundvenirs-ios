//
//  SVScannerViewController.h
//  Soundvenir
//
//  Created by Wolfgang Kluth on 12/06/14.
//  Copyright (c) 2014 360degrees. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface SVLocationScannerViewController : UIViewController <AVCaptureMetadataOutputObjectsDelegate, UIAlertViewDelegate>

@property (assign, nonatomic) BOOL touchToFocusEnabled;

- (BOOL) isCameraAvailable;
- (void) startScanning;
- (void) stopScanning;
- (void) setTourch:(BOOL) aStatus;

- (void) scanViewController:(SVLocationScannerViewController *) aCtler didTabToFocusOnPoint:(CGPoint) aPoint;
- (void) scanViewController:(SVLocationScannerViewController *) aCtler didSuccessfullyScan:(NSString *) aScannedValue;

@end