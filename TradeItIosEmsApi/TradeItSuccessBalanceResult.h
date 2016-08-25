//
//  TradeItSuccessBalanceResult.h
//  TradeItIosEmsApi
//
//  Created by Guillaume Debavelaere on 8/25/16.
//  Copyright © 2016 TradeIt. All rights reserved.
//

#import "TradeItResult.h"
#import "TradeItAccountOverview.h"
#import "TradeItFxAccountOverview.h"

@interface TradeItSuccessBalanceResult : TradeItResult

@property (copy) TradeItAccountOverview<Optional> *accountOverview;

@property (copy) TradeItFxAccountOverview<Optional> *fxAccountOverview;

@end
