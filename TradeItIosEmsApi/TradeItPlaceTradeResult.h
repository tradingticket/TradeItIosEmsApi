//
//  TradeItPlaceTradeResult.h
//  TradeItIosEmsApi
//
//  Created by Antonio Reyes on 2/2/16.
//  Copyright © 2016 TradeIt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TradeItResult.h"
#import "TradeItPlaceTradeOrderInfo.h"

@interface TradeItPlaceTradeResult : TradeItResult

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

/**
 *  Details about the order just placed
 */
@property (copy) TradeItPlaceTradeOrderInfo * orderInfo;

@end
