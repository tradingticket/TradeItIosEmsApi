//
//  TradeItSession.h
//  TradeItIosEmsApi
//
//  Created by Antonio Reyes on 1/15/16.
//  Copyright © 2016 TradeIt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TradeItConnector.h"
#import "TradeItResult.h"

@interface TradeItSession : NSObject

@property TradeItConnector * connector;

- (id) initWithConnector: (TradeItConnector *) connector;

- (TradeItResult *) authenticate;

/**
 *  Use this method to answer the broker secuirty question after the ems server sent a TradeItSecurityQuestionResult
 *
 *  @param answer security question answer
 *
 *  @return TradeItResult. Can either be TradeItStockOrEtfTradeReviewResult, TradeItSecurityQuestionResult or TradeItErrorResult. Caller needs to cast the result to the appropriate sub-class depending on the result status value. Note that TradeItSecurityQuestionResult will be returned again if the answer is incorrect. Session should be reset or if TradeItErrorResult is returned
 */
- (TradeItResult*) answerSecurityQuestion: (NSString*)answer;

- (TradeItResult *) closeSession;

- (TradeItResult *) keepSessionAlive;

@end
