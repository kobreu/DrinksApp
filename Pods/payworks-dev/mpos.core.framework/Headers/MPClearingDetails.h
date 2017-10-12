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


/**
 * Clearing details of a transaction.
 * @since 2.6.0
 */
@interface MPClearingDetails : NSObject

/**
 * The processing institute.
 * @since 2.6.0
 */
@property (strong, readonly, nonatomic, nullable) NSString *institute;

/**
 * The transaction identifier.
 * @since 2.6.0
 */
@property (strong, readonly, nonatomic, nullable) NSString *transactionIdentifier;

/**
 * The original transaction identifier (in case of a refund).
 * @since 2.6.0
 */
@property (strong, readonly, nonatomic, nullable) NSString *originalTransactionIdentifier;

/**
 * The completion date.
 * @since 2.6.0
 */
@property (strong, readonly, nonatomic, nullable) NSDate *completed;

/**
 * The authorization code.
 * @since 2.6.0
 */
@property (strong, readonly, nonatomic, nullable) NSString *authorizationCode;

/**
 * The merchant id.
 * @since 2.6.0
 */
@property (strong, readonly, nonatomic, nullable) NSString *merchantId;

/**
 * The terminal id.
 * @since 2.6.0
 */
@property (strong, readonly, nonatomic, nullable) NSString *terminalId;

/**
 * The status text.
 * @since 2.6.0
 */
@property (strong, readonly, nonatomic, nullable) NSString *statusText;

@end
