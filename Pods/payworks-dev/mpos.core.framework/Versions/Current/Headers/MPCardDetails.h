//
// PAYWORKS GMBH ("COMPANY") CONFIDENTIAL
// Copyright (c) 2016 Payworks GmbH, All Rights Reserved.
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
#import "MPPaymentDetails.h"


/**
 Extra details of the card, ex. fingerprint
 @since 2.8.0
 */
@interface MPCardDetails : NSObject

/**
 Card holder name
 @since 2.8.0
 */
@property (strong, readonly, nonatomic, nullable) NSString *cardHolderName;

/**
 Expiry month
 @since 2.8.0
 */
@property (assign, nonatomic, readonly) NSUInteger expiryMonth;

/**
 Expiry year
 @since 2.8.0
 */
@property (assign, nonatomic, readonly) NSUInteger expiryYear;

/**
 Unique fingerprint of the card
 @since 2.8.0
 */
@property (strong, readonly, nonatomic, nullable) NSString *fingerprint;

/**
 Masked card number
 @since 2.8.0
 */
@property (strong, readonly, nonatomic, nullable) NSString *maskedCardNumber;

/**
 Scheme
 @since 2.8.0
 */
@property (assign, nonatomic, readonly) MPPaymentDetailsScheme scheme;

@end
