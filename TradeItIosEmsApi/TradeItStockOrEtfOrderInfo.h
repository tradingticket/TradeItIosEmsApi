//
//  TradeItStockOrEtfOrderInfo.h
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/17/15.
//  Copyright (c) 2015 Serge Kreiker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TradeitStockOrEtfPrice.h"

typedef NS_ENUM(NSUInteger, TradeItStockOrEtfOrderAction){
    TradeItActionBuy = 0,
    TradeItActionSell,
    TradeItActionSellShort ,
    TradeItActionBuyToCover,
    TradeItActionUnknown
};

typedef NS_ENUM(NSUInteger, TradeItStockOrEtfOrderExpiration){
    TradeItExpirationDay = 0,
    TradeItExpirationGtc,
    TradeItExpirationUnknown
};

@interface TradeItStockOrEtfOrderInfo : NSObject

@property TradeItStockOrEtfOrderAction action;
@property int quantity;
@property (copy) NSString* symbol;
@property TradeItStockOrEtfOrderExpiration expiration;
@property (copy)TradeitStockOrEtfPrice *price;

- (NSString*) getActionString;
- (NSString*) getExpirationString;
- (id) initWithAction:(TradeItStockOrEtfOrderAction) action andQuantity:(double) quantity andSymbol:(NSString*)symbol andPrice:(TradeitStockOrEtfPrice*) price andExpiration:(TradeItStockOrEtfOrderExpiration) expiration;

@end
