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

@interface SVLocationScannerViewController : UIViewController <AVCaptureMetadataOutputObjectsDelegate, SVScannerViewControllerDelegate, UIAlertViewDelegate>

@property (nonatomic, weak) id<SVScannerViewControllerDelegate> delegate;

@property (assign, nonatomic) BOOL touchToFocusEnabled;

- (BOOL) isCameraAvailable;
- (void) startScanning;
- (void) stopScanning;
- (void) setTourch:(BOOL) aStatus;

@end

@protocol SVScannerViewControllerDelegate <NSObject>

@optional

- (void) scanViewController:(SVLocationScannerViewController *) aCtler didTabToFocusOnPoint:(CGPoint) aPoint;
- (void) scanViewController:(SVLocationScannerViewController *) aCtler didSuccessfullyScan:(NSString *) aScannedValue;

@end