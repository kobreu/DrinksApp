//
//  MPLocalizationToolbox.h
//  mpos.core
//
//  Created by Simon Eumes on 09.06.15.
//  Copyright (c) 2016 Payworks GmbH. All rights reserved.
//

#import "MPLocalizationToolbox.h"

@interface MPLocalizationToolbox ()

+ (NSTimeZone *)currentTimeZone;
+ (NSLocale *)bestMatchNSLocaleForAppConfiguration;

@end
