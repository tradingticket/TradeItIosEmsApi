//
//  TradeItStockOrEtfTradeManager.h
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/17/15.
//  Copyright (c) 2015 Serge Kreiker. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TradeItStockOrEtfOrderInfo.h"
#import "TradeItAuthenticationInfo.h"

#import "TradeitResult.h"
#import "TradeItMultipleAccountResult.h"
#import "TradeItSecurityQuestionResult.h"
#import "TradeItStockOrEtfTradeReviewResult.h"
#import "TradeItStockOrEtfTradeSuccessResult.h"
#import "TradeItErrorResult.h"
#import "TradeItTypeDefs.h"



/**
 *  Main class to manage authenticating sending orders to the Trade It Execution Management System (EMS). For each order a new session needs to be instantiated or reset should be called on the current session in order to clear the session order broker and authentication information.
 */
@interface TradeItStockOrEtfTradeSession : NSObject

/**
 *  App Name. Used to track and report requests from a given app. This value will be issues by Trade It
 */
@property (copy) NSString * publisherApp;

/**
 *  Environment to send the request to. Default value is TradeItEmsProductionEnv
 */
@property TradeitEmsEnvironments environment;

/**
 *  set the Order details
 */
@property (copy) TradeItStockOrEtfOrderInfo * orderInfo;

/**
 *  Set the Authentication details
 */
@property (copy) TradeItAuthenticationInfo * authenticationInfo;

/**
 *  Broker to send request to.
 * Possible values: Dummy (for testing only), TD, Etrade, Scottrade, Fidelity, Schwabs, TradeStation, Robinhood, OptionsHouse, IB
 * 
 */
@property (copy) NSString * broker;

/**
 *  Provide a full URL to recieve a POST response containing the details of a submitted order. Note, the EMS server does not return user data, if you wish to track a user you'll need to use your internal identifier in the url i.e. https://www.mytradesite.com/tradeitcallback/?user=12345
 */
@property (copy) NSString * postbackURL;

/**
 *  init a session with you app name provided by Trade it
 *
 *  @param publisherApp
 */
- (id) initWithpublisherApp:(NSString *) publisherApp;

/**
 *  Sets authenticationInfo, Order Info and send the authenticate and trade request to the EMS server.
 *
 *  @param authenticationInfo user's brokergage credentials
 *  @param orderInfo          Order Details
 *  @param broker             broker to sent the order to
 *
 *  @return TradeItResult. Can either be TradeItStockOrEtfTradeReviewResult, TradeItSecurityQuestionResult, TradeItMultipleAccountResult or TradeItErrorResult. Caller need to cast the result to the appropriate sub-class depending on the result status value. Session should be reset or if TradeItErrorResult is returned
 */
- (TradeItResult*) authenticateUser:(TradeItAuthenticationInfo*) authenticationInfo andReview:(TradeItStockOrEtfOrderInfo*) orderInfo withBroker:(NSString*) broker;

/**
 *  Can be called if orderInfo and authenticationInfo have been previously set for this session.
 *
 *  @return TradeItResult. Can either be TradeItStockOrEtfTradeReviewResult, TradeItSecurityQuestionResult, TradeItMultipleAccountResult or TradeItErrorResult. Caller need to cast the result to the appropriate sub-class depending on the result status value. Session should be reset or if TradeItErrorResult is returned
 */
- (TradeItResult*) authenticateAndReview;

/**
 *  Use this method to answer the broker secuirty question after the ems server sent a TradeItSecurityQuestionResult
 *
 *  @param answer security question answer
 *
 *  @return TradeItResult. Can either be TradeItStockOrEtfTradeReviewResult, TradeItSecurityQuestionResult, TradeItMultipleAccountResult or TradeItErrorResult. Caller need to cast the result to the appropriate sub-class depending on the result status value. Note that TradeItSecurityQuestionResult will be returned again if the answer is incorrect. Session should be reset or if TradeItErrorResult is returned
 */
- (TradeItResult*) answerSecurityQuestion: (NSString*)answer;

/**
 *  Use this method to select an account to trade in after the ems server sent a TradeItMultipleAccountResult
 *
 *  @param accountInfo should be the exact same account info object retruned by the ems server in the TradeItMultipleAccountResult, shich is an NSDictionary with a value and name field
 *
 *  @return TradeItResult. Can either be TradeItStockOrEtfTradeReviewResult or TradeItErrorResult. Caller needs to cast the result to the appropriate sub-class depending on the result status value. Session should be reset or if TradeItErrorResult is returned
 */
- (TradeItResult*) selectAccount: (NSDictionary*) accountInfo;

/**
 *  Use this method to place the order after the ems server sent back a TradeItStockOrEtfTradeReviewResult
 *
 *  @param accountInfo should be the exact same account info object retruned by the ems server in the TradeItMultipleAccountResult
 *
 *  @return TradeItResult. Can either be TradeItStockOrEtfTradeSuccessResult or TradeItErrorResult. Caller needs to cast the result to the appropriate sub-class depending on the result status value. Session should be reset after this call.
 */
- (TradeItResult*) placeOrder;

/**
 *  This function should be called if the flow is stopped after a TradeItSecurityQuestionResult a TradeItMultipleAccountResult or TradeItStockOrEtfTradeReviewResult without either answering the security quesytion, selecting an account or placing the order
 *  In case a TradeItStockOrEtfTradeSuccessResult or TradeItErrorResult the session is automatically closed by the ems server
 *
 *  @return return true if the session was succesfully closed
 */
- (BOOL) closeSession; //close session calls a reset

/**
 *  resets orderInfo, authenticationInfo and broker properties. Should be called for every new order placed or if an error result is returned
 */
- (void) reset;


/** @name async version of the apis @see synchronous version for description */

- (void) asyncAuthenticateAndReviewWithCompletionBlock:(TradeItRequestCompletionBlock) completionBlock;
- (void) asyncAuthenticateUser:(TradeItAuthenticationInfo*) authenticationInfo andReview:(TradeItStockOrEtfOrderInfo*) orderInfo withBroker:(NSString*) broker andCompletionBlock:(TradeItRequestCompletionBlock) completionBlock;
- (void) asyncAnswerSecurityQuestion: (NSString*)answer andCompletionBlock:(TradeItRequestCompletionBlock) completionBlock;
- (void) asyncSelectAccount: (NSDictionary*) accountInfo andCompletionBlock:(TradeItRequestCompletionBlock) completionBlock;
- (void) asyncPlaceOrderWithCompletionBlock:(TradeItRequestCompletionBlock) completionBlock;
- (void) asyncCloseSessionWithCompletionBlock:(void (^)(BOOL)) completionBlock;
@end
