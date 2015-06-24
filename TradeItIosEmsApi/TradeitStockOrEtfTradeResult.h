//
//  TradeitStockOrEtfTradeResult.h
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/23/15.
//  Copyright (c) 2015 TradeIt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TradeitStockOrEtfTradeResult : NSObject

@property (copy) NSString * token;
@property (copy) NSString * shortMessage;
@property (copy) NSArray* longMessages;

-(id) initWithToken:(NSString*) token andShortMessage:(NSString*) shortMessage andLongMessages:(NSArray*)longMessages;

@end
