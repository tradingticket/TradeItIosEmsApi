//
//  TradeItVerifyCredentialSession.h
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 7/14/15.
//  Copyright (c) 2015 TradeIt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TradeItAuthenticationInfo.h"

#import "TradeitResult.h"
#import "TradeItSuccessAuthenticationResult.h"
#import "TradeItErrorResult.h"
#import "TradeItTypeDefs.h"

@interface TradeItVerifyCredentialSession : NSObject


/**
 *  App Name. Used to track and report requests from a given app. This value will be issues by Trade It
 */
@property (copy) NSString * publisherApp;

/**
 *  Environment to send the request to. Default value is TradeItEmsProductionEnv
 */
@property TradeitEmsEnvironments environment;


/**
 *  init a session with you app name provided by Trade it
 *
 *  @param publisherApp
 */
- (id) initWithpublisherApp:(NSString *) publisherApp;

/**
 *  Verifies credentials with a given broker.
 *
 *  @param authenticationInfo user's brokergage credentials
 *  @param broker             broker to sent the order to
 *
 *  @return TradeItResult. Can either be TradeItSuccessAuthenticationResult or TradeItErrorResult if there was an issue accessing the Trade It server. Caller need to cast the result to the appropriate sub-class depending on the result status value.
 */
- (TradeItResult*) verifyUser:(TradeItAuthenticationInfo*) authenticationInfo withBroker:(NSString*) broker;

/**
 *  async version of verifyUser
 *
 *  @param completionBlock
 */
- (void) verifyUser:(TradeItAuthenticationInfo*) authenticationInfo withBroker:(NSString*) broker WithCompletionBlock:(TradeItRequestCompletionBlock) completionBlock;
@end
