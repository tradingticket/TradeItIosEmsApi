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
#import "TradeItAuthenticationResult.h"
#import "TradeItSecurityQuestionResult.h"
#import "TradeItSecurityQuestionRequest.h"
#import "TradeItAccount.h"

@implementation TradeItSession

- (id)initWithConnector:(TradeItConnector *)connector {
    self = [super init];
    if (self) {
        self.connector = connector;
    }
    return self;
}

- (void)authenticate:(TradeItLinkedLogin *)linkedLogin withCompletionBlock:(void (^)(TradeItResult *))completionBlock {
    NSString *userToken = [self.connector userTokenFromKeychainId:linkedLogin.keychainId];
    TradeItAuthenticationRequest *authRequest = [[TradeItAuthenticationRequest alloc] initWithUserToken:userToken
                                                                                                 userId:linkedLogin.userId
                                                                                              andApiKey:self.connector.apiKey];

    NSMutableURLRequest *request = buildJsonRequest(authRequest, @"user/authenticate", self.connector.environment);

    [self.connector sendEMSRequest:request
               withCompletionBlock:^(TradeItResult *result, NSMutableString *jsonResponse) {
        completionBlock([self parseAuthResponse:result
                                   jsonResponse:jsonResponse]);
    }];
}

- (void)authenticateAsObject:(TradeItLinkedLogin *)linkedLogin withCompletionBlock:(void (^)(TradeItResult *))completionBlock {
    [self authenticate:linkedLogin withCompletionBlock:^void(TradeItResult *tradeItResult) {
        if ([tradeItResult isKindOfClass:[TradeItAuthenticationResult class] ]) {
            TradeItAuthenticationResult *result = (TradeItAuthenticationResult*)tradeItResult;
            NSMutableArray<TradeItAccount *> *accounts = [[NSMutableArray alloc] init];
            NSArray *accountsArray = result.accounts;
            for (NSDictionary *accountDictionary in accountsArray) {
                TradeItAccount *account = [[TradeItAccount alloc] initWithAccountBaseCurrency:accountDictionary[@"accountBaseCurrency"]
                                                                                accountNumber:accountDictionary[@"accountNumber"]
                                                                                  accountName:accountDictionary[@"name"]
                                                                                     tradable:accountDictionary[@"tradable"]];
                [accounts addObject:account];
            }

            result.accounts = accounts;
            completionBlock(result);
        } else {
            completionBlock(tradeItResult);
        }
    }];

}


- (void)answerSecurityQuestion:(NSString *)answer
           withCompletionBlock:(void (^)(TradeItResult *))completionBlock {
    TradeItSecurityQuestionRequest *secRequest = [[TradeItSecurityQuestionRequest alloc] initWithToken:self.token andAnswer:answer];

    NSMutableURLRequest *request = buildJsonRequest(secRequest, @"user/answerSecurityQuestion", self.connector.environment);

    [self.connector sendEMSRequest:request
               withCompletionBlock:^(TradeItResult *result, NSMutableString *jsonResponse) {
        completionBlock([self parseAuthResponse:result
                                   jsonResponse:jsonResponse]);
    }];
}

- (TradeItResult *)parseAuthResponse:(TradeItResult *)result
                        jsonResponse:(NSMutableString *)jsonResponse {
    TradeItResult *resultToReturn = result;

    if ([result.status isEqual:@"SUCCESS"]) {
        resultToReturn = buildResult([TradeItAuthenticationResult alloc], jsonResponse);
        self.token = [(TradeItAuthenticationResult *)result token];
    } else if([result.status isEqualToString:@"INFORMATION_NEEDED"]) {
        resultToReturn = buildResult([TradeItSecurityQuestionResult alloc], jsonResponse);
        self.token = [(TradeItAuthenticationResult *)result token];
    }

    return resultToReturn;
}

-(void) keepSessionAliveWithCompletionBlock:(void (^)(TradeItResult *))completionBlock {
    NSLog(@"Implement me!!");
}

-(void) closeSession {
    NSLog(@"Implement me!!");
}

-(NSString *) description {
    return [NSString stringWithFormat:@"TradeItSession: %@", self.token];
}

@end
