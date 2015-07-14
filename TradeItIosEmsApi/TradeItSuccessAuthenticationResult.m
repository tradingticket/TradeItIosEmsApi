//
//  TradeItSuccessAuthenticationResult.m
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 7/14/15.
//  Copyright (c) 2015 TradeIt. All rights reserved.
//

#import "TradeItSuccessAuthenticationResult.h"

@implementation TradeItSuccessAuthenticationResult

- (id)init {
    self =  [super init];
    if(self){
        self.credentialsValid = NO;
    }
    return self;
}

- (NSString*) description{
    return [NSString stringWithFormat:@"TradeItSuccessAuthenticationResult: %@ credentialsValid=%d ",[super description], self.credentialsValid];
}

@end
