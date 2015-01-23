//
//  MPMagneticStripeReceiptDetailsWrapper.h
//  mpos.core
//
//  Created by Simon Eumes on 2/10/14.
//  Copyright (c) 2014 payworks GmbH. All rights reserved.
//

#import "MPAbstractReceiptDetailsWrapper.h"

/** 
 A receipt details wrapper for magstripe transactions, providing the details for the respective receipt.
 */
__attribute__((deprecated("Use MPReceiptFactory")))
@interface MPMagneticStripeReceiptDetailsWrapper : MPAbstractReceiptDetailsWrapper

/**
 * The name of the card used for the transaction.
 * @since 2.0.0
 */
@property (strong, readonly, nonatomic) NSString *cardLabel;
/**
 * The (masked) account number used for the transaction.
 * @since 2.0.0
 */
@property (strong, readonly, nonatomic) NSString *accountNumber;

@end
