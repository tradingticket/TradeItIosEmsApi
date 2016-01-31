//
//  TradeItTradeService.h
//  TradeItIosEmsApi
//
//  Created by Antonio Reyes on 1/15/16.
//  Copyright © 2016 TradeIt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TradeItResult.h"
#import "TradeItSession.h"
#import "TradeItPreviewTradeRequest.h"

@interface TradeItTradeService : NSObject

@property TradeItSession * session;

/* set the Order details */
@property (copy) TradeItPreviewTradeRequest * order;

-(id) initWithOrderRequest:(TradeItPreviewTradeRequest *) order;

- (TradeItResult *) previewTradeWithCompletionBlock:(void (^)(TradeItResult *)) completionBlock;

- (TradeItResult *) placeTrade;

@end
