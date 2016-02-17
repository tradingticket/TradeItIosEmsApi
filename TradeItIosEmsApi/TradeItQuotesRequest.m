//
//  TradeItQuotesRequest.m
//  TradeItIosEmsApi
//
//  Created by Antonio Reyes on 2/12/16.
//  Copyright © 2016 TradeIt. All rights reserved.
//

#import "TradeItQuotesRequest.h"

@implementation TradeItQuotesRequest

-(id) initWithSymbol:(NSString *) symbol {
    self = [super init];
    if(self) {
        self.symbol = symbol;
    }
    return self;
}

-(id) initWithSymbols:(NSArray *) symbols {
    self = [super init];
    if(self) {
        self.symbols = symbols;
    }
    return self;
}

@end
