//
//  TradeItMultipleAccountResult.m
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/24/15.
//  Copyright (c) 2015 TradeIt. All rights reserved.
//

#import "TradeItMultipleAccountResult.h"

@implementation TradeItMultipleAccountResult

- (id) init{
    self = [super init];
    
    if(self){
        self.accountList = nil;
    }
    return self;
}

- (NSString*) description{
    return [NSString stringWithFormat:@"TradeItMultipleAccountResult: %@ accountList=%@ ",[super description], self.accountList ];
}


@end
