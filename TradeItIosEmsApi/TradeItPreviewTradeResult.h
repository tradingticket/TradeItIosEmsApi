//
//  TradeItPreviewTradeResult.h
//  TradeItIosEmsApi
//
//  Created by Antonio Reyes on 1/30/16.
//  Copyright © 2016 TradeIt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TradeItResult.h"
#import "TradeItPreviewTradeOrderDetails.h"

@interface TradeItPreviewTradeResult : TradeItResult

/**
 *  An array containing all the warnings returned by the broker
 */
@property (copy) NSArray<Optional> * warningsList;

/**
 *  An array containing all the warnings that need to be acknowledged by the user. Should be displayed to the user with a checkbox asking him to review and acknowledge the following warnings before placing the order.
 */
@property (copy) NSArray<Optional> * ackWarningsList;

/**
 *  An Object with order details. @see TradeItStockOrEtfTradeReviewOrderDetails
 */
@property (copy) TradeItPreviewTradeOrderDetails * orderDetails;

@end
