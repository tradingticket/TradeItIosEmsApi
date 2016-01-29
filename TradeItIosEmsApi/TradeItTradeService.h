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
#import "TradeItStockOrEtfOrderInfo.h"

@interface TradeItTradeService : NSObject

@property TradeItSession * session;

/* set the Order details */
@property (copy) TradeItStockOrEtfOrderInfo * orderInfo;

/**
 *  Provide a full URL to recieve a POST response containing the details of a submitted order. Note, the EMS server does not return user data, if you wish to track a user you'll need to use your internal identifier in the url i.e. https://www.mytradesite.com/tradeitcallback/?user=12345
 */
@property (copy) NSString * postbackURL;

-(id) initWithOrderInfo:(TradeItStockOrEtfOrderInfo *) orderInfo;

- (TradeItResult *) previewTrade;

- (TradeItResult *) placeTrade;

@end
