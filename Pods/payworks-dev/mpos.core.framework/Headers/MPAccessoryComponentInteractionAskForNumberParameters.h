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
#import "MPTransaction.h"


/**
 * Prompt to be displayed when asking for a number
 * @since 2.10.0
 */
typedef NS_ENUM(NSUInteger, MPAccessoryComponentInteractionPrompt) {
    
    MPAccessoryComponentInteractionPromptEnterTip = 0,
    MPAccessoryComponentInteractionPromptEnterMobileNumber,
    MPAccessoryComponentInteractionPromptEnterTableNumber,
    MPAccessoryComponentInteractionPromptEnterAmount
};


/**
 * Options to customize a request for a number
 * @since 2.10.0
 */
@protocol MPAccessoryComponentInteractionAskForNumberOptionals <NSObject>

/**
 * Sets the format of the requested number
 * @param integerDigits Maximum number of digits for the integer part
 * @param fractionDigits Number of digits for the fraction part
 * @since 2.10.0
 */
- (void)setFormatWithIntegerDigits:(NSUInteger)integerDigits fractionDigits:(NSUInteger)fractionDigits;

/**
 * Autoconfirms a number once it achieved the maximum length the number can have, i.e. integerDigits + fractionDigits
 * @since 2.10.0
 */
- (void)setAutoConfirm:(BOOL)autoConfirm;

/**
 * A default number that is prefilled for confirmation
 * @since 2.10.0
 */
- (void)setDefaultNumber:(nonnull NSDecimalNumber*)defaultNumber;

/**
 * An amount to be displayed on top of the screen
 * @param amount Amount to display
 * @param currency Currency of the amount
 * @since 2.10.0
 */
- (void)setDisplayAmount:(nonnull NSDecimalNumber*)amount currency:(MPCurrency)currency;

/**
 * Shows idle screen after number is confirmed/canceled
 * @since 2.10.0
 */
- (void)setShowIdleScreen:(BOOL)showIdleScreen;

@end


typedef void (^MPAccessoryComponentInteractionAskForNumberOptionals)(id<MPAccessoryComponentInteractionAskForNumberOptionals> _Nonnull optionals);




/**
 * Parameters used to customize a request for a number
 * @since 2.10.0
 */
@interface MPAccessoryComponentInteractionAskForNumberParameters : NSObject

/**
 * Constructor for a new parameters object
 * @param prompt Prompt to be displayed on device
 * @param optionals Block that will be executed to further customize the request
 * @since 2.10.0
 */
+ (nonnull instancetype)parametersWithPrompt:(MPAccessoryComponentInteractionPrompt)prompt optionals:(nullable MPAccessoryComponentInteractionAskForNumberOptionals)optionalsBlock;

/**
 * Constructor for a new parameters object
 * @param promptIndexes array of NSNumber representing the indexes of prompts to be displayed on device.
                        For Miura:
                        Each element of the array represents the raw prompt index available on the Miura
                        The array can have a max length of 3, one index per line.
                        @0 indicates blank/empty.
 * @param optionals Block that will be executed to further customize the request
 * @since 2.10.0
 */
+ (nonnull instancetype)parametersWithPromptIndexes:(nonnull NSArray*)promptIndexes optionals:(nullable MPAccessoryComponentInteractionAskForNumberOptionals)optionalsBlock;

@end


