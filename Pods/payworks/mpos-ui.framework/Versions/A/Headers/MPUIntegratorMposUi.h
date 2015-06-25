//
//  MPUIntegratorMposUi.h
//  mpos-ui
//
//  Created by Korbinian Breu on 11/06/2015.
//  Copyright (c) 2015 payworks. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <mpos.core/mpos-extended.h>
#import "MPUMposUi.h"


/**
 * Describes to which application you would like to log in
 */
typedef NS_ENUM(NSUInteger, MPULogin) {
    /**
     * Login to SIX mCashier
     */
    MPULoginMcashier = 0,
    
    /**
     * Login to ConCardis OptiPay
     */
    MPULoginConCardis
};

@interface MPUIntegratorMposUi : NSObject

/**
 * Initializes the MposUi with the given login method and integrator identifier. The method *MUST* be called before any transaction can be started.
 * @param loginMethod The login to use
 * @param integratorIdentifier The integratorIdentifier to use
 */
+ (id)initializeWithLogin:(MPULogin)loginMethod integratorIdentifier:(NSString*) integratorIdentifier;

/**
 * Returns the mPOS UI to do charges, refunds, show transaction summaries...
 */
- (MPUMposUi*)mposUi;

/**
 * Shows the settings
 * @param viewController the view controller where the UI should be presented
 */
- (void)presentSettingsFromViewController:(UIViewController*)viewController;


/**
 * Logs the user out. Use this e.g. when the user logs out from your app.
 */
- (void)logout;

@end
