/*
 * mpos-ui : http://www.payworksmobile.com
 *
 * Copyright (c) 2015 payworks GmbH
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

#import <Foundation/Foundation.h>
#import <mpos.core/MPTransactionProvider.h>

@class MPUMposUiAppearance;

/**
 * Enum that describes the used receipt method.
 */
typedef NS_ENUM(NSUInteger, MPUMposUiConfigurationReceiptMethod) {
    /**
     * The summary screen shows a "send-receipt" button.
     */
    MPUMposUiConfigurationReceiptMethodReadyMade = 0,
    
    /**
     * The integrator has to implement its own receipt screen.
     * This is the default.
     */
    MPUMposUiConfigurationReceiptMethodOwnImplementation
};

/**
 * Enum that describes the uses signature method.
 */
typedef NS_ENUM(NSUInteger, MPUMposUiConfigurationSignatureMethod) {
    /**
     * The signature is taken electronically. This is the default.
     */
    MPUMposUiConfigurationSignatureMethodOnScreen = 0,
    
    /**
     * The signature is taken on paper after the transaction.
     */
    MPUMposUiConfigurationSignatureMethodOnReceipt

};


/**
 * Class to specify the behavior of certain ViewControllers.
 */
@interface MPUMposUiConfiguration : NSObject

/**
 * The accessory family that will be used for the transaction.
 */
@property (nonatomic, assign) MPAccessoryFamily accessoryFamily;

/**
 * The appearance that will be used for the transaction.
 */
@property (nonatomic, strong) MPUMposUiAppearance *appearance;

/**
 * The signature method that will be used for the transaction.
 */
@property (nonatomic, assign) MPUMposUiConfigurationSignatureMethod signatureMethod;

/**
 * The receipt method that will be used for the transaction.
 */
@property (nonatomic, assign) MPUMposUiConfigurationReceiptMethod receiptMethod;


@end
