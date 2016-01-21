//
//  TradeItConnector.h
//  TradeItIosEmsApi
//
//  Created by Antonio Reyes on 1/12/16.
//  Copyright © 2016 TradeIt. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TradeItTypeDefs.h"
#import "TradeItAccount.h"
#import "TradeItAuthenticationInfo.h"
#import "TradeItResult.h"

/**
   Main class to manage the connection (token) to the Trade It Execution Management System (EMS).
 */
@interface TradeItConnector : NSObject

/**
 *  The apiKey is generated by TradeIt and unique to your application and is required for all API requests
 */
@property NSString * apiKey;

/**
 *  Environment to send the request to. Default value is TradeItEmsProductionEnv
 *  Tokens are specific to environment
 */
@property TradeitEmsEnvironments environment;

/**
 *  Connectors will always need an API key
 */
- (id) initWithApiKey:(NSString *) apiKey;

/**
 *  Return an array with all the brokers that support stockOrEtfTrading and are enabled for a given apiKey
 *
 *  @return Array NSDictionary objects, where each object has a "longName" and "shortName". The longName should be displauyed to the user and the short name should be used wbe sending a request to the ems server
 */
- (void) getAvailableBrokersWithCompletionBlock:(void (^)(NSArray *)) completionBlock;

/**
 */
- (NSArray *) getLinkedAccounts;

/**
 */
- (TradeItResult *) linkBrokerWithAuthenticationInfo: (TradeItAuthenticationInfo *) authInfo;

/**
 */
- (TradeItResult *) unlinkBroker: (NSString *) broker;

/**
 */
- (TradeItResult *) updateUserToken: (NSString *) token;

@end
