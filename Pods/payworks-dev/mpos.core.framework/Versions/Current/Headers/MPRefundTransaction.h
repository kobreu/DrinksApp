//
// PAYWORKS GMBH ("COMPANY") CONFIDENTIAL
// Copyright (c) 2015 Payworks GmbH, All Rights Reserved.
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

#import "MPTransaction.h"


/**
 * The code of a refund transaction. It describes in more detail how the refund was made
 * @since 2.8.0
 */
typedef NS_ENUM(NSUInteger, MPRefundTransactionCode) {
    /** Unknown or not available */
    MPRefundTransactionCodeUnknown = 0,
    /** Refund was executed before clearing the initial transaction */
    MPRefundTransactionCodeRefundBeforeClearing,
    /** Refund was executed after clearing  the initial transaction */
    MPRefundTransactionCodeRefundAfterClearing,
    /** The refunded amount is the remainder after a partial capture of the initial transaction */
    MPRefundTransactionCodePartialCapture,
};

/**
 * Object grouping some details about the associated refunds for a transaction.
 * @since 2.4.1
 */
@interface MPRefundTransaction : NSObject

/**
 * The reference within our infrastructure to identify the transaction (payworks identifier).
 * @since 2.4.4
 */
@property (strong, readonly, nonatomic, nullable) NSString *identifier;

/**
 * Timestamp when the transaction was created. This timestamp will always be UTC.
 * @since 2.4.4
 */
@property (strong, readonly, nonatomic, nullable) NSDate *created;

/**
 * The amount of the transaction.
 * @since 2.8.0
 */
@property (strong, readonly, nonatomic, nonnull) NSDecimalNumber *amount;

/**
 * The currency used for the transaction.
 * @since 2.8.0
 */
@property (assign, readonly, nonatomic) MPCurrency currency;

/**
 * The type the transaction.
 * @since 2.4.4
 */
@property (assign, readonly, nonatomic) MPTransactionType type;

/**
 * The detailed code of transaction type
 * @since 2.8.0
 */
@property (assign, readonly, nonatomic) MPRefundTransactionCode code;

/**
 * Current state of the transaction. Approved, Declined and Error are the final states.
 * @since 2.4.4
 */
@property (assign, readonly, nonatomic) MPTransactionStatus status;

/**
 * Additional details associated with the current status, providing more detailed information for the current status and debug information.
 * @since 2.4.4
 */
@property (strong, readonly, nonatomic, nullable) MPStatusDetails *statusDetails;

@end
