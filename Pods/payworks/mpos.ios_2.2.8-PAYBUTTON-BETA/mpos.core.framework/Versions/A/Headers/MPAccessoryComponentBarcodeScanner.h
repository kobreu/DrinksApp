//
//  MPBarcodeComponentC.h
//  mpos.core
//
//  Created by Leonid Popescu on 6/19/14.
//  Copyright (c) 2014 payworks GmbH. All rights reserved.
//

#import "MPAccessoryComponent.h"

@class MPAccessoryComponentBarcodeScannerConfiguration;
@class MPAccessoryComponentBarcodeScanner;

typedef void (^MPBarcodeComponentStartScanSuccess)(MPAccessoryComponentBarcodeScanner *component);
typedef void (^MPBarcodeComponentScan)(MPAccessoryComponentBarcodeScanner *component, NSData *data);
typedef void (^MPBarcodeComponentButton)(MPAccessoryComponentBarcodeScanner *component, NSUInteger buttonStatus);
typedef void (^MPBarcodeComponentStartScanFailure)(MPAccessoryComponentBarcodeScanner *component, NSError *error) ;


typedef void (^MPBarcodeComponentStopScanSuccess)(MPAccessoryComponentBarcodeScanner *component);
typedef void (^MPBarcodeComponentStopScanFailure)(MPAccessoryComponentBarcodeScanner *component, NSError *error);

@interface MPAccessoryComponentBarcodeScanner : MPAccessoryComponent

@property (strong, nonatomic) MPAccessoryComponentBarcodeScannerConfiguration *config;

- (void)startScan:(MPBarcodeComponentStartScanSuccess)success
             scan:(MPBarcodeComponentScan)scan
           button:(MPBarcodeComponentButton)button
          failure:(MPBarcodeComponentStartScanFailure)failure;


- (void)stopScan:(MPBarcodeComponentStopScanSuccess)success
         failure:(MPBarcodeComponentStopScanFailure)failure;
@end