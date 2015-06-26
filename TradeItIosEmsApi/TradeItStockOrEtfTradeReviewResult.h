//
//  TradeitStockOrEtfTradeReviewResult.h
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/23/15.
//  Copyright (c) 2015 TradeIt. All rights reserved.
//

#import "TradeItResult.h"
#import "TradeItStockOrEtfTradeReviewOrderDetails.h"

@interface TradeItStockOrEtfTradeReviewResult : TradeItResult

@property (copy) NSArray<Optional> * warningsList;
@property (copy) NSArray<Optional> * ackWarningsList;
@property (copy) TradeItStockOrEtfTradeReviewOrderDetails * orderDetails;

@end
