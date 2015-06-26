//
//  TradeItStockOrEtfTradeSuccessResult.h
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/23/15.
//  Copyright (c) 2015 TradeIt. All rights reserved.
//

#import "TradeItResult.h"

@interface TradeItStockOrEtfTradeSuccessResult : TradeItResult

@property (copy) NSString * confirmationMessage;
@property (copy) NSString * orderNumber;
@property (copy) NSString * timestamp;
@property (copy) NSString * broker;


@end
