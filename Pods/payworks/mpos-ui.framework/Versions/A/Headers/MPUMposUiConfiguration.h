//
// PAYWORKS GMBH ("COMPANY") CONFIDENTIAL
// Copyright (c) 2015 payworks GmbH, All Rights Reserved.
//
// NOTICE:  All information contained herein is, and remains the property of COMPANY. The intellectual and technical concepts contained
// herein are proprietary to COMPANY and may be covered by European or foreign Patents, patents in process, and are protected by trade secret or copyright law.
// Dissemination of this information or reproduction of this material is strictly forbidden unless prior written permission is obtained
// from COMPANY.  Access to the source code contained herein is hereby forbidden to anyone except current COMPANY employees, managers or contractors who have executed
// Confidentiality and Non-disclosure agreements explicitly covering such access.
//
// The copyright notice above does not evidence any actual or intended publication or disclosure of this source code, which includes
// information that is confidential and/or proprietary, and is a trade secret, of COMPANY.
// ANY REPRODUCTION, MODIFICATION, DISTRIBUTION, PUBLIC  PERFORMANCE,
// OR PUBLIC DISPLAY OF OR THROUGH USE  OF THIS  SOURCE CODE  WITHOUT  THE EXPRESS WRITTEN CONSENT OF COMPANY IS STRICTLY PROHIBITED, AND IN VIOLATION OF APPLICABLE
// LAWS AND INTERNATIONAL TREATIES.  THE RECEIPT OR POSSESSION OF  THIS SOURCE CODE AND/OR RELATED INFORMATION DOES NOT CONVEY OR IMPLY ANY RIGHTS
// TO REPRODUCE, DISCLOSE OR DISTRIBUTE ITS CONTENTS, OR TO MANUFACTURE, USE, OR SELL ANYTHING THAT IT  MAY DESCRIBE, IN WHOLE OR IN PART.

#import <Foundation/Foundation.h>
#import <mpos.core/MPTransactionProvider.h>

@class MPUMposUiAppearance;

/**
 * Enum that describes the used receipt method.
 */
typedef NS_ENUM(NSUInteger, MPUMposUiConfigurationReceiptMethod) {
    /**
     * The summary screen shows a "send-receipt" button.
     */
    MPUMposUiConfigurationReceiptMethodReadyMade = 0,
    
    /**
     * The integrator has to implement its own receipt screen.
     * This is the default.
     */
    MPUMposUiConfigurationReceiptMethodOwnImplementation
};

/**
 * Enum that describes the uses signature method.
 */
typedef NS_ENUM(NSUInteger, MPUMposUiConfigurationSignatureMethod) {
    /**
     * The signature is taken electronically. This is the default.
     */
    MPUMposUiConfigurationSignatureMethodOnScreen = 0,
    
    /**
     * The signature is taken on paper after the payment.
     */
    MPUMposUiConfigurationSignatureMethodOnReceipt

};


/**
 * Class to specify the behavior of certain ViewControllers.
 */
@interface MPUMposUiConfiguration : NSObject

/**
 * The accessory family that will be used for the payment.
 */
@property (nonatomic, assign) MPAccessoryFamily accessoryFamily;

/**
 * The appearance that will be used for the payment.
 */
@property (nonatomic, strong) MPUMposUiAppearance *appearance;

/**
 * The signature method that will be used for the payment.
 */
@property (nonatomic, assign) MPUMposUiConfigurationSignatureMethod signatureMethod;

/**
 * The receipt method that will be used for the payment.
 */
@property (nonatomic, assign) MPUMposUiConfigurationReceiptMethod receiptMethod;


@end
