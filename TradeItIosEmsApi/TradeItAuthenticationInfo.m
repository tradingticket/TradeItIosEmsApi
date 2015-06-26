//
//  TradeItRequestAuthenticationInfo.m
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/17/15.
//  Copyright (c) 2015 Serge Kreiker. All rights reserved.
//

#import "TradeItAuthenticationInfo.h"

@implementation TradeItAuthenticationInfo

- (id) initWithId:(NSString *)id andPassword:(NSString*) password{
    self = [super init];
    if (self) {
        self.id = id;
        self.password = password;
    }
    return self;
}

- (id) init {
    return [self initWithId:@"" andPassword:@""];
}

-(NSString*) description {
    return [NSString stringWithFormat:@"TradeItAuthenticationInfo: id:%@ password:%@", self.id, self.password];
}

- (id)copyWithZone:(NSZone *)zone
{
    id copy = [[[self class] alloc] initWithId:self.id andPassword:self.password];
    return copy;
}

@end
