//
//  SVScannerViewController.m
//  Soundvenir
//
//  Created by Wolfgang Kluth on 12/06/14.
//  Copyright (c) 2014 360degrees. All rights reserved.
//

#import "SVScannerViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <MapKit/MapKit.h>
#import "SVCollectedSong.h"
#import "SVAppDelegate.h"
#import "SVPlayerViewController.h"
#import "UIViewController+BackButtonHandler.h"

@interface SVScannerViewController ()

@property (strong, nonatomic) AVCaptureDevice* device;
@property (strong, nonatomic) AVCaptureDeviceInput* input;
@property (strong, nonatomic) AVCaptureMetadataOutput* output;
@property (strong, nonatomic) AVCaptureSession* session;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer* preview;
@property (weak, nonatomic) IBOutlet UIView *scannerView;
@property (strong, nonatomic) SVCollectedSong *loadedSong;

@end

@implementation SVScannerViewController

- (void)viewWillAppear:(BOOL)animated;
{
    [super viewWillAppear:animated];
    
    self.view.backgroundColor = [UIColor clearColor];
    self.view.tintColor = [UIColor clearColor];
}

- (void) viewDidAppear:(BOOL)animated;
{
    [super viewDidAppear:animated];
    
    self.delegate = self;
    
    if(![self isCameraAvailable]) {
        [self setupNoCameraView];
    } else {
        [self setupScanner];
    }
    
    [self startScanning];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)evt
{
    if(self.touchToFocusEnabled) {
        UITouch *touch=[touches anyObject];
        CGPoint pt= [touch locationInView:self.view];
        [self focus:pt];
    }
}

// qr-code scanned
- (void) scanViewController:(SVScannerViewController *) aCtler didSuccessfullyScan:(NSString *) aScannedValue {
    
    // TODO: check if qr-code a sound-location (compare location, check UDID)
    
    [self stopScanning];
    
    // www.soundvenirs.com/api/sounds/:uuid
    
    NSString *soundUrl = [NSString stringWithFormat:@"http://www.soundvenirs.com/api/sounds/%@", aScannedValue];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:soundUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *locationDict = responseObject[@"location"];
        CLLocationCoordinate2D location = CLLocationCoordinate2DMake([locationDict[@"lat"] doubleValue], [locationDict[@"long"] doubleValue]);
        
        SVCollectedSong *collectedSong = [SVCollectedSong collectedSong:responseObject[@"uuid"] andTitle:responseObject[@"title"] andLocation:location songUrl:responseObject[@"mp3url"]];
        
        SVAppDelegate *appDelegate = (SVAppDelegate *)[UIApplication sharedApplication].delegate;
        
        BOOL isDuplicated = false;
        
        if ([appDelegate.collectedSongs count] > 0) {
            for (SVCollectedSong *tmpSong in appDelegate.collectedSongs) {
                if ([tmpSong.uuid isEqual:collectedSong.uuid]) {
                    isDuplicated = true;
                    break;
                }
            }
        }
        

        
        if (!isDuplicated) {
            [appDelegate.collectedSongs addObject:collectedSong];
        }
        
        self.loadedSong = collectedSong;
        
        [self performSegueWithIdentifier:@"PushToPlayer" sender:self];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    SVPlayerViewController *playerViewController = [segue destinationViewController];
    playerViewController.currentSongLocation = self.loadedSong;
}

#pragma mark -
#pragma mark NoCamAvailable

- (void) setupNoCameraView;
{
    UILabel *labelNoCam = [[UILabel alloc] init];
    labelNoCam.text = @"No Camera available";
    labelNoCam.textColor = [UIColor blackColor];
    [self.view addSubview:labelNoCam];
    [labelNoCam sizeToFit];
    labelNoCam.center = self.view.center;
}

- (NSUInteger)supportedInterfaceOrientations;
{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL)shouldAutorotate;
{
    return (UIDeviceOrientationIsPortrait([[UIDevice currentDevice] orientation]));
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation;
{
    if([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait) {
        AVCaptureConnection *con = self.preview.connection;
        con.videoOrientation = AVCaptureVideoOrientationPortraitUpsideDown;
    } else {
        AVCaptureConnection *con = self.preview.connection;
        con.videoOrientation = AVCaptureVideoOrientationPortrait;
    }
}

#pragma mark -
#pragma mark AVFoundationSetup

- (void) setupScanner;
{
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    self.session = [[AVCaptureSession alloc] init];
    
    self.output = [[AVCaptureMetadataOutput alloc] init];
    [self.session addOutput:self.output];
    [self.session addInput:self.input];
    
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    self.output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    
    self.preview = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    self.preview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    AVCaptureConnection *con = self.preview.connection;
    
    con.videoOrientation = AVCaptureVideoOrientationPortrait;
    
    [self.scannerView.layer insertSublayer:self.preview atIndex:0];
}

#pragma mark -
#pragma mark Helper Methods

- (BOOL) isCameraAvailable;
{
    NSArray *videoDevices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    return [videoDevices count] > 0;
}

- (void)startScanning;
{
    [self.session startRunning];
    
}

- (void) stopScanning;
{
    [self.session stopRunning];
    [self.preview removeFromSuperlayer];
}

- (void) setTourch:(BOOL) aStatus;
{
  	AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    [device lockForConfiguration:nil];
    if ( [device hasTorch] ) {
        if ( aStatus ) {
            [device setTorchMode:AVCaptureTorchModeOn];
        } else {
            [device setTorchMode:AVCaptureTorchModeOff];
        }
    }
    [device unlockForConfiguration];
}

- (void) focus:(CGPoint) aPoint;
{
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if([device isFocusPointOfInterestSupported] &&
       [device isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        double screenWidth = screenRect.size.width;
        double screenHeight = screenRect.size.height;
        double focus_x = aPoint.x/screenWidth;
        double focus_y = aPoint.y/screenHeight;
        if([device lockForConfiguration:nil]) {
            if([self.delegate respondsToSelector:@selector(scanViewController:didTabToFocusOnPoint:)]) {
                [self.delegate scanViewController:self didTabToFocusOnPoint:aPoint];
            }
            [device setFocusPointOfInterest:CGPointMake(focus_x,focus_y)];
            [device setFocusMode:AVCaptureFocusModeAutoFocus];
            if ([device isExposureModeSupported:AVCaptureExposureModeAutoExpose]){
                [device setExposureMode:AVCaptureExposureModeAutoExpose];
            }
            [device unlockForConfiguration];
        }
    }
}

#pragma mark -
#pragma mark AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects
       fromConnection:(AVCaptureConnection *)connection
{
    for(AVMetadataObject *current in metadataObjects) {
        if([current isKindOfClass:[AVMetadataMachineReadableCodeObject class]]) {
            if([self.delegate respondsToSelector:@selector(scanViewController:didSuccessfullyScan:)]) {
                NSString *scannedValue = [((AVMetadataMachineReadableCodeObject *) current) stringValue];
                [self.delegate scanViewController:self didSuccessfullyScan:scannedValue];
            }
        }
    }
}
@end
