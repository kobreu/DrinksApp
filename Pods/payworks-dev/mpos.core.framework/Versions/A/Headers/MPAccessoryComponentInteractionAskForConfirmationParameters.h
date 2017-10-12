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


/**
 * Keys to which accessory can react
 * @since 2.10.0
 */
typedef NS_OPTIONS(NSUInteger, MPAccessoryComponentInteractionConfirmationKey) {
    
    MPAccessoryComponentInteractionConfirmationKeyOk        = 1 << 0,
    MPAccessoryComponentInteractionConfirmationKeyCancel    = 1 << 1,
    MPAccessoryComponentInteractionConfirmationKeyBack      = 1 << 2,
    MPAccessoryComponentInteractionConfirmationKeyNumeric   = 1 << 3
};


/**
 * Options to customize a confirmation request
 * @since 2.10.0
 */
@protocol MPAccessoryComponentInteractionAskForConfirmationParametersOptionals <NSObject>

/**
 * Centers the text on accessory display.
 * @since 2.10.0
 */
- (void)setCenterText:(BOOL)centered;

/**
 * Shows idle screen after confirmation. Default YES.
 * @since 2.10.0
 */
- (void)setShowIdleScreen:(BOOL)showIdleScreen;

/**
 * Sets the keys to react to in the confirmation prompt
 * @param keys Bit mask with enabled keys. Default is MPAccessoryComponentInteractionConfirmationKeyOk | MPAccessoryComponentInteractionConfirmationKeyCancel
 * @since 2.10.0
 */
- (void)setConfirmationKeys:(MPAccessoryComponentInteractionConfirmationKey)keys;

@end


typedef void (^MPAccessoryComponentInteractionAskForConfirmationParametersOptionals)(id<MPAccessoryComponentInteractionAskForConfirmationParametersOptionals> _Nonnull optionals);


/**
 * Parameters used to customize a request for a confirmation
 * @since 2.10.0
 */
@interface MPAccessoryComponentInteractionAskForConfirmationParameters : NSObject

/**
 * Constructor for a new parameters object
 * @param text Array of strings where each string represents a line of text
 * @since 2.10.0
 */
+ (nonnull instancetype)parametersWithText:(nonnull NSArray*)text optionals:(nullable MPAccessoryComponentInteractionAskForConfirmationParametersOptionals)optionalsBlock;

@end
