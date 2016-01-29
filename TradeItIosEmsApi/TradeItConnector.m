//
//  TradeItConnector.m
//  TradeItIosEmsApi
//
//  Created by Antonio Reyes on 1/12/16.
//  Copyright © 2016 TradeIt. All rights reserved.
//

#import "TradeItConnector.h"
#import "TradeItStockOrEtfBrokerListRequest.h"
#import "TradeItEmsUtils.h"
#import "TradeItErrorResult.h"
#import "TradeItBrokerListSuccessResult.h"
#import "TradeItKeychain.h"
#import "TradeItAuthLinkRequest.h"

@implementation TradeItConnector {
    BOOL runAsyncCompletionBlockOnMainThread;
}

NSString * BROKER_LIST_KEYNAME = @"TRADEIT_BROKERS";
NSString * USER_DEFAULTS_SUITE = @"TRADEIT";

- (id)initWithApiKey:(NSString *) apiKey {
    self = [super init];
    if (self) {
        self.apiKey = apiKey;
        self.environment = TradeItEmsProductionEnv;
        runAsyncCompletionBlockOnMainThread = true;
    }
    return self;
}

- (void) getAvailableBrokersWithCompletionBlock:(void (^)(NSArray *)) completionBlock {
    TradeItStockOrEtfBrokerListRequest * brokerListRequest = [[TradeItStockOrEtfBrokerListRequest alloc] initWithApiKey:self.apiKey];
    NSMutableURLRequest *request = buildJsonRequest(brokerListRequest, @"preference/getStocksOrEtfsBrokerList", self.environment);
    
    [self sendEMSRequest:request withCompletionBlock:^(TradeItResult * tradeItResult, NSMutableString * jsonResponse) {
         
         if([tradeItResult isKindOfClass: [TradeItErrorResult class]]){
             NSLog(@"Could not fetch broker list, got error result%@ ", tradeItResult);
         }
         else if ([tradeItResult.status isEqual:@"SUCCESS"]){
             TradeItBrokerListSuccessResult* successResult = (TradeItBrokerListSuccessResult*) buildResult([TradeItBrokerListSuccessResult alloc],jsonResponse);
            
             completionBlock(successResult.brokerList);
             
             return;
         }
         else if ([tradeItResult.status isEqual:@"ERROR"]){
             NSLog(@"Could not fetch broker list, got error result%@ ", tradeItResult);
         }
         
         completionBlock(nil);
    }];
}

-(void) linkBrokerWithAuthenticationInfo: (TradeItAuthenticationInfo *) authInfo andCompletionBlock:(void (^)(TradeItResult *)) completionBlock {
    TradeItAuthLinkRequest * authLinkRequest = [[TradeItAuthLinkRequest alloc] initWithAuthInfo:authInfo andAPIKey:self.apiKey];
    
    NSMutableURLRequest * request = buildJsonRequest(authLinkRequest, @"user/oAuthLink", self.environment);
    
    [self sendEMSRequest:request withCompletionBlock:^(TradeItResult * tradeItResult, NSMutableString * jsonResponse) {
        
        if ([tradeItResult.status isEqual:@"SUCCESS"]){
            TradeItAuthLinkResult* successResult = (TradeItAuthLinkResult*) buildResult([TradeItAuthLinkResult alloc],jsonResponse);
            
            tradeItResult = successResult;
        }
        
        completionBlock(tradeItResult);
    }];
    
}

-(void) saveLinkToKeychain: (TradeItAuthLinkResult *) link withBroker: (NSString *) broker {
    return [self saveLinkToKeychain:link withBroker:broker andLabel:broker];
}

-(void) saveLinkToKeychain: (TradeItAuthLinkResult *) link withBroker: (NSString *) broker andLabel:(NSString *) label {
    NSUserDefaults * standardUserDefaults = [[NSUserDefaults alloc] initWithSuiteName:USER_DEFAULTS_SUITE];
    NSMutableArray * accounts = [[NSMutableArray alloc] initWithArray:[self getLinkedLogins]];
    NSString * keychainId = [[NSUUID UUID] UUIDString];
    
    NSDictionary * newRecord = @{@"label":label,
                                 @"broker":broker,
                                 @"userId":link.userId,
                                 @"keychainId":keychainId};
    [accounts addObject:newRecord];
    
    [standardUserDefaults setObject:accounts forKey:BROKER_LIST_KEYNAME];
    
    [TradeItKeychain saveString:link.userToken forKey:keychainId];
}

- (NSArray *) getLinkedLogins {
    NSUserDefaults * standardUserDefaults = [[NSUserDefaults alloc] initWithSuiteName:USER_DEFAULTS_SUITE];
    NSArray * linkedAccounts = [standardUserDefaults arrayForKey:BROKER_LIST_KEYNAME];
    
    if(!linkedAccounts) {
        linkedAccounts = [[NSArray alloc] init];
    }
    
    NSMutableArray * accountsToReturn = [[NSMutableArray alloc] init];
    for (NSDictionary * account in linkedAccounts) {
        [accountsToReturn addObject: [[TradeItLinkedLogin alloc] initWithLabel:account[@"label"] broker:account[@"broker"] userId:account[@"userId"] andKeyChainId:account[@"keychainId"]]];
    }
    
    return accountsToReturn;
}

- (void) unlinkBroker: (NSString *) broker {
    NSUserDefaults * standardUserDefaults = [[NSUserDefaults alloc] initWithSuiteName:USER_DEFAULTS_SUITE];
    NSMutableArray * accounts = [[NSMutableArray alloc] initWithArray:[self getLinkedLogins]];
    
    [accounts enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary * account = (NSDictionary *) obj;
        if([account[@"broker"] isEqualToString:broker]) {
            [accounts removeObjectAtIndex:idx];
        }
    }];
    
    [standardUserDefaults setObject:accounts forKey:BROKER_LIST_KEYNAME];
}

-(NSString *) userTokenFromKeychainId:(NSString *) keychainId {
    return [TradeItKeychain getStringForKey:keychainId];
}

- (TradeItResult *) updateUserToken: (TradeItLinkedLogin *) linkedLogin {
    NSLog(@"Implement Me");
    return [[TradeItResult alloc] init];
}

-(void) sendEMSRequest:(NSMutableURLRequest *) request withCompletionBlock:(void (^)(TradeItResult *, NSMutableString *)) completionBlock {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^(void){
        NSHTTPURLResponse *response;
        NSError *error;
        NSData *responseJsonData = [NSURLConnection sendSynchronousRequest:request
                                                         returningResponse:&response
                                                                     error:&error];
        
        if ((responseJsonData==nil) || ([response statusCode]!=200)) {
            //error occured
            NSLog(@"ERROR from EMS server response=%@ error=%@", response, error);
            dispatch_async(dispatch_get_main_queue(),^(void){completionBlock(nil,nil);});
            return;
        }
        
        NSMutableString *jsonResponse = [[NSMutableString alloc] initWithData:responseJsonData encoding:NSUTF8StringEncoding];
        
        //first convert to a generic result to check the type
        TradeItResult * tradeItResult = buildResult([TradeItResult alloc],jsonResponse);
        
        if([tradeItResult.status isEqual:@"ERROR"]){
            TradeItErrorResult * errorResult;
            
            if(![tradeItResult isKindOfClass: [TradeItErrorResult class]]) {
                errorResult = (TradeItErrorResult *) buildResult([TradeItErrorResult alloc],jsonResponse); //this is an error as served directly from the EMS server
            } else {
                errorResult = (TradeItErrorResult *) tradeItResult; //this type of error caused by something wrong parsing the response
            }
            
            tradeItResult = errorResult;
        }
        
        dispatch_async(dispatch_get_main_queue(),^(void){completionBlock(tradeItResult, jsonResponse);});
    });

}

@end
