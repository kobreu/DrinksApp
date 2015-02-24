//
// PAYWORKS GMBH ("COMPANY") CONFIDENTIAL
// Copyright (c) 2013 payworks GmbH, All Rights Reserved.
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

#import "MPAbstractReceiptDetailsWrapper.h"

/**
 * A receipt details wrapper for EMV transactions, providing the required details for a respective receipt.
 * @since 2.0.0
 */
__attribute__((deprecated("Use MPReceiptFactory")))
@interface MPEMVReceiptDetailsWrapper : MPAbstractReceiptDetailsWrapper

/**
 * The ID of the application on the card that was used for the transaction.
 * @since 2.0.0
 */
@property (strong, readonly, nonatomic) NSString *applicationID;
/**
 * The name of the application used for the transaction.
 * @since 2.0.0
 */
@property (strong, readonly, nonatomic) NSString *applicationLabel;

/**
 * The authorization code for the transaction.
 * @since 2.0.0
 */
@property (strong, readonly, nonatomic) NSString *authorizationCode;
/**
 * The verification result compiled by the terminal.
 * @since 2.0.0
 */
@property (strong, readonly, nonatomic) NSString *terminalVerificationResult;
/**
 * The status information for the transaction.
 * @since 2.0.0
 */
@property (strong, readonly, nonatomic) NSString *transactionStatusInformation;
/**
 * The (masked) account number used for the transaction.
 * @since 2.0.0
 */
@property (strong, readonly, nonatomic) NSString *accountNumber;

@end
