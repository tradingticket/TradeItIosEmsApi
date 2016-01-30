//
//  TradeItSession.m
//  TradeItIosEmsApi
//
//  Created by Antonio Reyes on 1/15/16.
//  Copyright © 2016 TradeIt. All rights reserved.
//

#import "TradeItSession.h"
#import "TradeItAuthenticationRequest.h"
#import "TradeItEmsUtils.h"
#import "TradeItErrorResult.h"
#import "TradeItSuccessAuthenticationResult.h"
#import "TradeItSecurityQuestionResult.h"

@implementation TradeItSession

- (id) initWithConnector: (TradeItConnector *) connector {
    self = [super init];
    if (self) {
        self.connector = connector;
    }
    return self;
}

-(void) authenticate:(TradeItLinkedLogin *)linkedLogin withCompletionBlock:(void (^)(TradeItResult *))completionBlock {
    NSString * userToken = [self.connector userTokenFromKeychainId:linkedLogin.keychainId];
    TradeItAuthenticationRequest * authRequest = [[TradeItAuthenticationRequest alloc] initWithUserToken:userToken userId:linkedLogin.userId andApiKey:self.connector.apiKey];
    
    NSMutableURLRequest * request = buildJsonRequest(authRequest, @"user/authenticate", self.connector.environment);
    
    [self.connector sendEMSRequest:request withCompletionBlock:^(TradeItResult * result, NSMutableString * jsonResponse) {
        TradeItResult * resultToReturn = result;
        
        if ([result.status isEqual:@"SUCCESS"]){
            resultToReturn = buildResult([TradeItSuccessAuthenticationResult alloc], jsonResponse);
            self.token = [(TradeItSuccessAuthenticationResult *)result token];
        }
        else if([result.status isEqualToString:@"INFORMATION_NEEDED"]) {
            resultToReturn = buildResult([TradeItSecurityQuestionResult alloc], jsonResponse);
        }
        
        completionBlock(resultToReturn);
    }];
}

-(void) answerSecurityQuestion:(NSString *)answer withCompletionBlock:(void (^)(TradeItResult *))completionBlock {
    
}

-(void) keepSessionAliveWithCompletionBlock:(void (^)(TradeItResult *))completionBlock {
    
}

-(void) closeSession {
    
}

@end
