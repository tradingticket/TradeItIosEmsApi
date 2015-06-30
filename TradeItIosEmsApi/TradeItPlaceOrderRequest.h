//
//  TradeItPlaceOrderRequest.h
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/26/15.
//  Copyright (c) 2015 TradeIt. All rights reserved.
//

#import "TradeItRequest.h"

@interface TradeItPlaceOrderRequest : TradeItRequest

@property NSString* token;

-(id) initWithToken: (NSString*)token ;

@end
