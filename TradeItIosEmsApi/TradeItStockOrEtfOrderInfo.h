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

/**
 *  Use this Class to create an order that can be sent to the Trade It Execution Management System (EMS) server
 */
@interface TradeItStockOrEtfOrderInfo : JSONModel<NSCopying>

/**
 *  The order action. Possible values are buy, sell, sellShort or buyToCover. Setting any orther value will result with the Exexution Management System (EMS) server returning an error
 *  To prevent from errors you shoud use the init method taht taks a TradeItStockOrEtfOrderAction enum
 */
@property (copy) NSString* action; //can only be buy, sell, sellShort or buyToCover setter will throw exception if another value is provided

/**
 *  The number of shares to trade
 */
@property int quantity;

/**
 *  The stock or ETF symbol to trade. The EMS server uses dot notation for class A and B shares (i.e BRK.A)
 */
@property (copy) NSString* symbol;

/**
 *  The order duration. Possible values are day or gtc. Setting any orther value will result with the EMS server returning an error
 *  If price type is market or action is sellShort, then only day can be passed. Setting any orther value will result with the EMS server returning an error
 *  To prevent from errors you shoud use the init method taht taks a TradeItStockOrEtfOrderExpiration enum
 */
@property (copy) NSString* expiration;


/**
 *  The order price. @see TradeitStockOrEtfOrderPrice
 */
@property (copy)TradeitStockOrEtfOrderPrice *price;


/**
 *  init Method
 *
 *  @param action
 *  @param quantity
 *  @param symbol
 *  @param price
 *  @param expiration
 *
 */
- (id) initWithAction:(TradeItStockOrEtfOrderAction) action andQuantity:(double) quantity andSymbol:(NSString*)symbol andPrice:(TradeitStockOrEtfOrderPrice*) price andExpiration:(TradeItStockOrEtfOrderExpiration) expiration;

@end
