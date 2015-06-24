//
//  TradeitStockOrEtfTradeSecurityQuestionResult.h
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/24/15.
//  Copyright (c) 2015 TradeIt. All rights reserved.
//

#import "TradeitStockOrEtfTradeResult.h"
#import <Foundation/Foundation.h>

@interface TradeitStockOrEtfTradeSecurityQuestionResult : TradeitStockOrEtfTradeResult

//only one of securityQuestion,securityQuestionOptions or challengeImage will not be nil
@property (copy) NSString * securityQuestion;
@property (copy) NSArray * securityQuestionOptions;
@property (copy) NSString* challengeImage;
@property (copy) NSString* informationShortMessage;
@property (copy) NSString* informationLongMessage;
@property (copy) NSArray * errorFields;

- (id)initWithToken:(NSString *)token andShortMessage:(NSString *)shortMessage andLongMessages:(NSArray *)longMessages andSecurityQuestion: (NSString*)securityQuestion andInformationShortMessage:(NSString*) informationShortMessage andInformationLongMessage:(NSString*)informationLongMessage andErrorFields:(NSArray*)errorFields;

- (id) initWithToken:(NSString *)token andShortMessage:(NSString *)shortMessage andLongMessages:(NSArray *)longMessages andSecurityQuestionOptions: (NSArray*)securityQuestionOptions andInformationShortMessage:(NSString*) informationShortMessage andInformationLongMessage:(NSString*)informationLongMessage andErrorFields:(NSArray*)errorFields;

- (id) initWithToken:(NSString *)token andShortMessage:(NSString *)shortMessage andLongMessages:(NSArray *)longMessages andChallengeImage: (NSString*)challengeImage andInformationShortMessage:(NSString*) informationShortMessage andInformationLongMessage:(NSString*)informationLongMessage andErrorFields:(NSArray*)errorFields;

@end
