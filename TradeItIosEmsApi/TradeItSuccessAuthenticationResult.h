//
//  TradeItSuccessAuthenticationResult.h
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 7/14/15.
//  Copyright (c) 2015 TradeIt. All rights reserved.
//

#import "TradeItResult.h"

@interface TradeItSuccessAuthenticationResult : TradeItResult

/**
 *  true if credentials are valid false otherwise
 */
@property BOOL credentialsValid;

@end
