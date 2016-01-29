//
//  TradeItSession.m
//  TradeItIosEmsApi
//
//  Created by Antonio Reyes on 1/15/16.
//  Copyright © 2016 TradeIt. All rights reserved.
//

#import "TradeItSession.h"

@implementation TradeItSession

- (id) initWithConnector: (TradeItConnector *) connector {
    self = [super init];
    if (self) {
        self.connector = connector;
    }
    return self;
}

-(void) authenticate:(NSString *)userToken withCompletionBlock:(void (^)(TradeItResult *))completionBlock {
    
}

-(void) answerSecurityQuestion:(NSString *)answer withCompletionBlock:(void (^)(TradeItResult *))completionBlock {
    
}

-(void) keepSessionAliveWithCompletionBlock:(void (^)(TradeItResult *))completionBlock {
    
}

-(void) closeSession {
    
}

@end
