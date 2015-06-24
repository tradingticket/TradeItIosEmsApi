//
//  TradeitStockOrEtfTradeReviewResult.h
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/23/15.
//  Copyright (c) 2015 TradeIt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TradeitStockOrEtfTradeResult.h"
#import "TradeItStockOrEtfReviewOrderDetails.h"

@interface TradeitStockOrEtfTradeReviewResult : TradeitStockOrEtfTradeResult

@property (copy) NSArray * warnings;
@property (copy) NSArray * ackWarnings;
@property (copy) TradeItStockOrEtfReviewOrderDetails * orderDetails;

- (id) initWithToken:(NSString *)token
     andShortMessage:(NSString *)shortMessage
     andLongMessages:(NSArray *)longMessages
     andOrderDetails:(TradeItStockOrEtfReviewOrderDetails*) orderDetails
         andWarnings:(NSArray*) warnings
     andAckWarnings:(NSArray*) ackWarnings;

@end
