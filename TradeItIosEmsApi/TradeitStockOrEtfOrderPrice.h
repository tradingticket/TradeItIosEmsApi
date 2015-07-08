//
//  TradeitStockOrEtfOrderPrice.h
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/17/15.
//  Copyright (c) 2015 Serge Kreiker. All rights reserved.
//

#import "JSONModel.h"

/**
 *  use this class to set the order price
 */
@interface TradeitStockOrEtfOrderPrice : JSONModel<NSCopying>

/**
 *  Set the type of the Order, possible values are market, limit, stopMarket or stopLimit.
 *  You should not set the type directly but instead use the appropriate init method. Setting any orther value will result with the Exexution Management System (EMS) server returning an error
 *  Note that if the broker is Robinhood then only market and limitOrder are supported. Setting any other order type for Robinhood will result with the EMS server returning an error.
 */
@property (copy) NSString*  type;

/**
 *  Set limit price for limit, and stopLimit orders
 */
@property (copy) NSNumber<Optional>* limitPrice;

// Set stop price for stopLimit and and stopMarket
@property (copy) NSNumber<Optional>* stopPrice;


/**
 *  Use this function to create a market order. This fuction will automatically set the type to market
 */
- (id) initMarket;

/**
 *  Use this function to create a limit order. This fuction will automatically set the type to limit
 *
 *  @param limitPrice
 */
- (id) initLimit: (double) limitPrice;

/**
 *  Use this function to create a stop limit order . This fuction will automatically set the type to stopLimit
 *
 *  @param limitPrice
 *  @param stopPrice
 */
- (id) initStopLimit: (double) limitPrice : (double) stopPrice;

/**
 *  Use this function to create a stop market order. This fuction will automatically set the type to stopMarket
 *
 *  @param stopPrice
 */
- (id) initStopMarket: (double) stopPrice;

@end
