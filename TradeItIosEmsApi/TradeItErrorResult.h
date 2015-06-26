//
//  TradeItErrorResult.h
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/26/15.
//  Copyright (c) 2015 TradeIt. All rights reserved.
//

#import "TradeItResult.h"

@interface TradeItErrorResult : TradeItResult

@property (copy) NSString<Optional> *systemMessage;
@property (copy) NSArray<Optional>* errorFields;

+(TradeItErrorResult*) tradeErrorWithSystemMessage:(NSString*) systemMessage;

@end
