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
#import <UIKit/UIKit.h>
#import <mpos.core/mpos-extended.h>

@class MPTransaction;
@class MPUMposUiConfiguration;
@class MPUPaymentParameters;

/**
 * Enum describing the result of the payment.
 */
typedef NS_ENUM(NSUInteger, MPUMposUiTransactionResult) {
    /**
     * The payment was approved.
     */
    MPUMposUiTransactionResultApproved = 0,
    
    /**
     * The payment failed. This might be due an error or the transaction was declined / aborted.
     */
    MPUMposUiTransactionResultFailed
};


typedef void (^MPUPaymentControllerCompleted)(UIViewController *controller, MPUMposUiTransactionResult result, MPTransaction *transaction);

/**
 * Shared factory that creates different ViewController that guide you through a transaction.
 */
@interface MPUMposUi : NSObject

/**
 * The last transaction that has been processed.
 */
@property (nonatomic, strong) MPTransaction *transaction;

/**
 * The details about the last transaction that has been processed.
 */
@property (nonatomic, strong) MPTransactionProcessDetails *transactionProcessDetails;

/**
 * The configuration for creating new controllers.
 */
@property (nonatomic, strong) MPUMposUiConfiguration *configuration;


/**
 * Returns the version of the SDK.
 * @return The version of the SDK
 * @since 2.0.0
 */
+ (NSString *)version;

/**
 * Initializes the MposUi. The method *MUST* be called before any payment can be started.
 * @param providerMode The mode to use
 * @param merchantIdentifier The merchant identifier to use
 * @param merchantSecret The merchant secret to use
 */
+ (id)initializeWithProviderMode:(MPProviderMode)providerMode merchantIdentifier:(NSString *)merchantIdentifier merchantSecret:(NSString *)merchantSecret;


/**
 * Creates an UIViewController that starts the payments und updates its views accordingly.
 * @param sessionIdentifier The session reference for the transaction to process.
 * @param completed Completed callback notifying about the completion of a transaction. The ViewController can be dismissed afterwards.
 * @return The ViewController ready to be pushed for display
 */
- (UIViewController *)createTransactionViewControllerWithSessionIdentifier:(NSString *)sessionIdentifier completed:(MPUPaymentControllerCompleted)completed;


/**
 * Creates an UIViewController that starts the payments und updates its views accordingly.
 * @param amount The amount for the transaction.
 * @param currency The currency for the transaction.
 * @param subject The subject for the transaction.
 * @param customIdentifier The custom identifier for the transaction.
 * @param completed Completed callback notifying about the completion of a transaction. The ViewController can be dismissed afterwards.
 * @return The ViewController ready to be pushed for display
 */
- (UIViewController *)createTransactionViewControllerWithAmount:(NSDecimalNumber *)amount currency:(MPCurrency)currency subject:(NSString *)subject customIdentifier:(NSString *)customIdentifier completed:(MPUPaymentControllerCompleted)completed;

/**
 * Returns an instance of the initialized MposUi.
 * @return The initialized instance or nil of none is initialized.
 */
+ (MPUMposUi *)sharedInitializedInstance;

@end
