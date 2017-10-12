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


#import "MPAccessoryComponent.h"
#import "MPTransaction.h"

#import "MPAccessoryComponentInteractionAskForNumberParameters.h"
#import "MPAccessoryComponentInteractionAskForConfirmationParameters.h"

@class MPAccessoryComponentInteraction;

/**
 * Ask for confirmation completion handler
 * @param key The key that was pressed on the device
 * @since 2.10.0
 */
typedef void (^MPAccessoryComponentInteractionConfirmationSuccess)(MPAccessoryComponentInteraction * _Nonnull component, MPAccessoryComponentInteractionConfirmationKey key);

/**
 * Ask for confirmation failure handler
 * @param error Error that describes why the confirmation failed
 * @since 2.10.0
 */
typedef void (^MPAccessoryComponentInteractionConfirmationFailure)(MPAccessoryComponentInteraction * _Nonnull component, NSError * _Nonnull error);

/**
 * Asking for confirmation was aborted
 * @since 2.11.0
 */
typedef void (^MPAccessoryComponentInteractionConfirmationAbort)(MPAccessoryComponentInteraction * _Nonnull component);


/**
 * Ask for number completion handler
 * @param number The number entered as a string. This could include leading zeroes so parse it appropriately in case where a 0 is expected.
 * @since 2.11.1
 */
typedef void (^MPAccessoryComponentInteractionAskForNumberSuccess)(MPAccessoryComponentInteraction * _Nonnull component, NSString * _Nonnull number);

/**
 * Ask for number failure handler
 * @param error Error that describes why it failed
 * @since 2.10.0
 */
typedef void (^MPAccessoryComponentInteractionAskForNumberFailure)(MPAccessoryComponentInteraction * _Nonnull component, NSError * _Nonnull error);

/**
 * Asking for confirmation was aborted
 * @since 2.11.0
 */
typedef void (^MPAccessoryComponentInteractionAskForNumberAbort)(MPAccessoryComponentInteraction * _Nonnull component);


/**
 * Display text completion handler
 * @since 2.11.0
 */
typedef void (^MPAccessoryComponentInteractionDisplayTextSuccess)(MPAccessoryComponentInteraction * _Nonnull component);

/**
 * Display text failure handler
 * @param error Error that occurred during the process
 * @since 2.11.0
 */
typedef void (^MPAccessoryComponentInteractionDisplayTextFailure)(MPAccessoryComponentInteraction * _Nonnull component, NSError * _Nonnull error);


/**
 * Display idle screen completion handler
 * @since 2.11.0
 */
typedef void (^MPAccessoryComponentInteractionDisplayIdleScreenSuccess)(MPAccessoryComponentInteraction * _Nonnull component);

/**
 * Display idle screen failure handler
 * @param error Error that occurred during the process
 * @since 2.11.0
 */
typedef void (^MPAccessoryComponentInteractionDisplayIdleScreenFailure)(MPAccessoryComponentInteraction * _Nonnull component, NSError * _Nonnull error);


/**
 * An additional component of an accessory which provides a way to ask user for a confirmation
 * @since 2.10.0
 */
@interface MPAccessoryComponentInteraction : MPAccessoryComponent

/**
 * The component asks the user for a custom confirmation
 * @param parameters Parameters used to customize the request
 * @param success Executed when user confirms/declines
 * @param failure Executed when something went wrong
 * @since 2.10.0
 */
- (void)askForConfirmationWithParameters:(nonnull MPAccessoryComponentInteractionAskForConfirmationParameters*)params
                                 success:(nonnull MPAccessoryComponentInteractionConfirmationSuccess)success
                                   abort:(nonnull MPAccessoryComponentInteractionConfirmationAbort)abort
                                 failure:(nonnull MPAccessoryComponentInteractionConfirmationFailure)failure;


/**
 * The component asks the user for a number, displaying one or more prompts
 * @param parameters Parameters used to customize the request
 * @success Executed when user entered a number
 * @failure Executed when something went wrong
 * @since 2.10.0
 */
- (void)askForNumberWithParameters:(nonnull MPAccessoryComponentInteractionAskForNumberParameters*)params
                           success:(nonnull MPAccessoryComponentInteractionAskForNumberSuccess)success
                             abort:(nonnull MPAccessoryComponentInteractionAskForNumberAbort)abort
                           failure:(nonnull MPAccessoryComponentInteractionAskForNumberFailure)failure;



/**
 * Displays the text on the accessory.
 * @param text The text to display on the accessory. Array of NSString where each string represents a line of text
 * @param success Executed when text was displayed successfully
 * @param failure Executed when something went wrong
 * @since 2.11.0
 */
- (void)displayText:(nonnull NSArray *)text
            success:(nonnull MPAccessoryComponentInteractionDisplayTextSuccess)success
            failure:(nonnull MPAccessoryComponentInteractionDisplayTextFailure)failure;


/**
 * Displays the idle screen on the accessory.
 * @param success Executed when idle screen was displayed successfully
 * @param failure Executed when something went wrong
 * @since 2.11.0
 */
- (void)displayIdleScreenSuccess:(nonnull MPAccessoryComponentInteractionDisplayIdleScreenSuccess)success
                         failure:(nonnull MPAccessoryComponentInteractionDisplayIdleScreenFailure)failure;

@end
