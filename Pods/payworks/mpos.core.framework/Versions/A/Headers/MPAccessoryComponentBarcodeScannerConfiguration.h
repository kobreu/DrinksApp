//
//  MPBarcodeConfig.h
//  mpos.core
//
//  Created by Leonid Popescu on 06.06.2014.
//  Copyright (c) 2014 payworks GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(int, MPBarcodeTriggerMode) {
    MPBarcodeTriggerModeEdge = 0,
    MPBarcodeTriggerModeLevel,
    MPBarcodeTriggerModeSoft,
    MPBarcodeTriggerModePassive
};

typedef NS_ENUM(int, MPBarcodeScanMode) {
    MPBarcodeScanMode1D = 0,
    MPBarcodeScanMode1D2D
};


typedef NS_ENUM(int, MPBarcodeMessageFormat) {
    MPBarcodeMessageFormatStripped = 0,
    MPBarcodeMessageFormatOriginalXPI
};


@interface MPAccessoryComponentBarcodeScannerConfiguration : NSObject

@property (assign, nonatomic) MPBarcodeTriggerMode triggerMode;
@property (assign, nonatomic) MPBarcodeScanMode scanMode;
@property (assign, nonatomic) MPBarcodeMessageFormat messageFormat;

@end
