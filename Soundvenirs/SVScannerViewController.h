//
//  SVScannerViewController.h
//  Soundvenir
//
//  Created by Wolfgang Kluth on 12/06/14.
//  Copyright (c) 2014 360degrees. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol SVScannerViewControllerDelegate;

@interface SVScannerViewController : UIViewController <AVCaptureMetadataOutputObjectsDelegate>

@property (assign, nonatomic) BOOL touchToFocusEnabled;

- (BOOL) isCameraAvailable;
- (void) startScanning;
- (void) stopScanning;
- (void) setTourch:(BOOL) aStatus;
- (void) scanViewController:(SVScannerViewController *) aCtler didTabToFocusOnPoint:(CGPoint) aPoint;
- (void) scanViewController:(SVScannerViewController *) aCtler didSuccessfullyScan:(NSString *) aScannedValue;

@end