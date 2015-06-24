//
//  TradeItStockOrEtfTradeMultipleAccountResult.h
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/24/15.
//  Copyright (c) 2015 TradeIt. All rights reserved.
//

#import "TradeitStockOrEtfTradeResult.h"

@interface TradeItStockOrEtfTradeMultipleAccountResult : TradeitStockOrEtfTradeResult

@property (copy) NSArray * accountList;

- (id)initWithToken:(NSString *)token andShortMessage:(NSString *)shortMessage andLongMessages:(NSArray *)longMessages andAccountList:(NSArray* )accountList;

@end
