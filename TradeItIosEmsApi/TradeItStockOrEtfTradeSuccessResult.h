//
//  TradeItStockOrEtfTradeSuccessResult.h
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/23/15.
//  Copyright (c) 2015 TradeIt. All rights reserved.
//

#import "TradeItResult.h"

/**
 *  Returned if the order was succesfully placed
 */
@interface TradeItStockOrEtfTradeSuccessResult : TradeItResult

/**
 *  Message providing a recap of the order that was placed
 */
@property (copy) NSString * confirmationMessage;

/**
 *  The order number returned by the broker
 */
@property (copy) NSString * orderNumber;

/**
 *  Date the order was entered in US Eastern time
 */
@property (copy) NSString * timestamp;

/**
 *  The broker the order was placed with
 */
@property (copy) NSString * broker;


@end
