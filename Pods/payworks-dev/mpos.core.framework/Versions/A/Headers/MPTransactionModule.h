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

@class MPTransaction;
@class MPTransactionFilterParameters;

/**
 * Callback block for a transaction lookup with transaction identifier.
 * @param transaction The transaction with the provided transactionIdentifier
 * @param error The error that might have occured
 * @since 2.6.0
 */
typedef void (^MPTransactionModuleLookupByTransactionIdentifierCompleted)(MPTransaction * _Nullable transaction, NSError * _Nullable error);


/**
 * Callback block for a transaction query with transaction filter.
 * @param transactions The returned transactions (nil if error occured, may be empty if no transcations where found)
 * @param error The error that might have occured
 * @since 2.6.0
 */
typedef void (^MPTransactionModulQueryCompleted)(NSArray * _Nullable transactions, NSError * _Nullable error);


/**
 * Callback block for a sending a receipt for a transaction.
 * @param error The error that might have occured
 * @since 2.6.0
 */
typedef void (^MPTransactionModuleSendingCustomerReceiptCompleted)(NSString * _Nonnull transactionIdentifier, NSString * _Nonnull emailAddress, NSError * _Nullable error);


/**
 * @since 2.6.0
 */
@interface MPTransactionModule : NSObject

/**
 * Queries a transaction by its identifier.
 * @param transactionIdentifier The identifier of the transaction
 * @param completed The async completion callback
 * @since 2.6.0
 */
- (void)lookupTransactionWithTransactionIdentifier:(nonnull NSString *)transactionIdentifier
                                         completed:(nonnull MPTransactionModuleLookupByTransactionIdentifierCompleted)completed;



/**
 * Queries transactions filtered by properties set in filterParameters.
 * The returned transaction objects are paginated, the defaul offset is set to 0 and the number of returned transactions is limited to 20.
    To use different values use queryTransactionsUsingFilters:includeReceipts:range:completed:
 * The transactions are sorted by time in descending order.
 * @param filterParameters The filtering parameters which are used for querying transactions. May be nil if no filtering is required.
 * @param completed The async completion callback
 * @since 2.6.0
 */
- (void)queryTransactionsUsingFilters:(nullable MPTransactionFilterParameters*)filterParameters
                            completed:(nonnull MPTransactionModulQueryCompleted)completed;


/**
 * Queries transactions filtered by properties set in filterParameters.
 * The transactions are sorted by time in descending order.
 * @param filterParameters The filtering parameters which are used for querying transactions. May be nil if no filtering is required.
 * @param includeReceipts Defines if the returned transaction objects should have customer and merchant receipt information embedded.
 * @param range The range of transactions to be returned, *index* specifies the offset of the first transaction and *length* limits the number of transactions to return.
 * @param completed The async completion callback
 * @since 2.6.0
 */
- (void)queryTransactionsUsingFilters:(nullable MPTransactionFilterParameters*)filterParameters
                      includeReceipts:(BOOL)includeReceipts
                                range:(NSRange)range
                            completed:(nonnull MPTransactionModulQueryCompleted)completed;


/**
 * Sends a receipt for the given transaction.
 * @param transactionIdentifier The transaction identifier to generate the receipt for
 * @param emailAddress Email receiver of the receipt
 * @param completed The async completion block
 * @since 2.6.0
 */
- (void)sendCustomerReceiptForTransactionIdentifier:(nonnull NSString *)transactionIdentifier
                                       emailAddress:(nonnull NSString *)emailAddress
                                          completed:(nonnull MPTransactionModuleSendingCustomerReceiptCompleted)completed;
@end
