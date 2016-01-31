//
//  TradeitStockOrEtfTradeReviewResult.h
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/23/15.
//  Copyright (c) 2015 TradeIt. All rights reserved.
//

#import "TradeItResult.h"
#import "TradeItPreviewTradeOrderDetails.h"

/**
 *  Returned if the order does nto have any errors and can be placed with the broker
 */
@interface TradeItStockOrEtfTradeReviewResult : TradeItResult

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
