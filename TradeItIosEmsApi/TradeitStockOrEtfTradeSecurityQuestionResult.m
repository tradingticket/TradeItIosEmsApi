//
//  TradeitStockOrEtfTradeSecurityQuestionResult.m
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/24/15.
//  Copyright (c) 2015 TradeIt. All rights reserved.
//

#import "TradeitStockOrEtfTradeSecurityQuestionResult.h"

@implementation TradeitStockOrEtfTradeSecurityQuestionResult

- (id) initWithToken:(NSString *)token andShortMessage:(NSString *)shortMessage andLongMessages:(NSArray *)longMessages andSecurityQuestion: (NSString*)securityQuestion andInformationShortMessage:(NSString*) informationShortMessage andInformationLongMessage:(NSString*)informationLongMessage andErrorFields:(NSArray*)errorFields{
    
    self = [super initWithToken:token andShortMessage:shortMessage andLongMessages:longMessages];
    if(self){
        self.securityQuestion  = securityQuestion;
        self.securityQuestionOptions = nil;
        self.challengeImage = nil;
        self.informationShortMessage = informationShortMessage;
        self.informationLongMessage = informationLongMessage;
        self.errorFields = errorFields;
    }
    return self;
}

- (id) initWithToken:(NSString *)token andShortMessage:(NSString *)shortMessage andLongMessages:(NSArray *)longMessages andSecurityQuestionOptions: (NSArray*)securityQuestionOptions andInformationShortMessage:(NSString*) informationShortMessage andInformationLongMessage:(NSString*)informationLongMessage andErrorFields:(NSArray*)errorFields{
    
    self = [super initWithToken:token andShortMessage:shortMessage andLongMessages:longMessages];

    if(self){
        self.securityQuestion  = nil;
        self.securityQuestionOptions = securityQuestionOptions;
        self.challengeImage = nil;
        self.informationShortMessage = informationShortMessage;
        self.informationLongMessage = informationLongMessage;
        self.errorFields = errorFields;
    }
    return self;
}

- (id) initWithToken:(NSString *)token andShortMessage:(NSString *)shortMessage andLongMessages:(NSArray *)longMessages andChallengeImage: (NSString*)challengeImage andInformationShortMessage:(NSString*) informationShortMessage andInformationLongMessage:(NSString*)informationLongMessage andErrorFields:(NSArray*)errorFields{
    
    self = [super initWithToken:token andShortMessage:shortMessage andLongMessages:longMessages];

    if(self){
        self.securityQuestion  = nil;
        self.securityQuestionOptions = nil;
        self.challengeImage = challengeImage;
        self.informationShortMessage = informationShortMessage;
        self.informationLongMessage = informationLongMessage;
        self.errorFields = errorFields;
    }
    return self;
}

- (id) init{
    
    self = [super init];
    
    if(self){
        self.securityQuestion  = nil;
        self.securityQuestionOptions = nil;
        self.challengeImage = nil;
        self.informationShortMessage = nil;
        self.informationLongMessage = nil;
        self.errorFields = nil;
    }
    return self;
}

- (NSString*) description{
    return [NSString stringWithFormat:@"TradeitStockOrEtfTradeSecurityQuestionResult: %@ securityQuestion=%@ securityQuestionOptions=%@ challengeImage=%@",[super description], self.securityQuestion,self.securityQuestionOptions,self.challengeImage ];
}

@end
