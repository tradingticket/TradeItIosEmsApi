//
//  TradeItStockOrEtfOrderInfo.h
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/17/15.
//  Copyright (c) 2015 Serge Kreiker. All rights reserved.
//

#import "JSONModel.h"
#import "TradeitStockOrEtfOrderPrice.h"

typedef NS_ENUM(NSUInteger, TradeItStockOrEtfOrderAction){
    TradeItStockOrEtfOrderActionBuy = 0,
    TradeItStockOrEtfOrderActionSell,
    TradeItStockOrEtfOrderActionSellShort ,
    TradeItStockOrEtfOrderActionBuyToCover,
    TradeItStockOrEtfOrderActionUnknown
};

typedef NS_ENUM(NSUInteger, TradeItStockOrEtfOrderExpiration){
    TradeItStockOrEtfOrderExpirationDay = 0,
    TradeItStockOrEtfOrderExpirationGtc,
    TradeItStockOrEtfOrderExpirationUnknown
};

@interface TradeItStockOrEtfOrderInfo : JSONModel<NSCopying>

@property (copy) NSString* action; //can only be buy, sell, sellShort or buyToCover setter will throw exception if another value is provided
@property int quantity;
@property (copy) NSString* symbol;
@property (copy) NSString* expiration; //can only be day or gtc setter will throw exception if another value is provided

@property (copy)TradeitStockOrEtfOrderPrice *price;

- (id) initWithAction:(TradeItStockOrEtfOrderAction) action andQuantity:(double) quantity andSymbol:(NSString*)symbol andPrice:(TradeitStockOrEtfOrderPrice*) price andExpiration:(TradeItStockOrEtfOrderExpiration) expiration;

@end
