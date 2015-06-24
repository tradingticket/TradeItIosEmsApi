//
//  TradeitStockOrEtfTradeSuccessResult.h
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/23/15.
//  Copyright (c) 2015 TradeIt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TradeitStockOrEtfTradeResult.h"

@interface TradeitStockOrEtfTradeSuccessResult : TradeitStockOrEtfTradeResult

@property (copy) NSString * confirmationMessage;
@property (copy) NSString * orderNumber;
@property (copy) NSString * timestamp;
@property (copy) NSString * broker;


-(id) initWithToken:(NSString *)token
    andShortMessage:(NSString *)shortMessage
    andLongMessages:(NSArray *)longMessages
    andOrderNumber: (NSString*) orderNumber
    andConfirmationMessage:(NSString*) confirmationMessage
    andTimestamp: (NSString* )timestamp
    andBroker:(NSString*) broker;

@end
