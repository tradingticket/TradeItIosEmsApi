//
//  TradeItStockOrEtfTradeInProgressResult.h
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/24/15.
//  Copyright (c) 2015 TradeIt. All rights reserved.
//

#import "TradeitStockOrEtfTradeResult.h"

@interface TradeItStockOrEtfTradeInProgressResult : TradeitStockOrEtfTradeResult

-(id) initWithToken:(NSString*) token andShortMessage:(NSString*) shortMessage ;

@end
