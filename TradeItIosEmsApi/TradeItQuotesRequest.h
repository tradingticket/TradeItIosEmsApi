//
//  TradeItQuotesRequest.h
//  TradeItIosEmsApi
//
//  Created by Antonio Reyes on 2/12/16.
//  Copyright © 2016 TradeIt. All rights reserved.
//

#import "TradeItRequest.h"

@interface TradeItQuotesRequest : TradeItRequest

@property (copy) NSString * symbol;
@property (copy) NSString * symbols;

-(id) initWithSymbol:(NSString *) symbol;
-(id) initWithSymbols:(NSArray *) symbols;


// Session Token - Will be set by the session associated with the request
// Setting this here will be overriden
@property (copy) NSString * token;

@end
