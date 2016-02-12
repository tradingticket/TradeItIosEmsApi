//
//  TradeItQuoteRequest.m
//  TradeItIosEmsApi
//
//  Created by Antonio Reyes on 2/12/16.
//  Copyright © 2016 TradeIt. All rights reserved.
//

#import "TradeItQuoteRequest.h"

@implementation TradeItQuoteRequest

-(id) initWithSymbol:(NSString *) symbol {
    self = [super init];
    if(self) {
        self.symbol = symbol;
    }
    return self;
}

@end
