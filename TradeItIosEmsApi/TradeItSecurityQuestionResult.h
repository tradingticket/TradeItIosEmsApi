//
//  TradeItSecurityQuestionResult.h
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/24/15.
//  Copyright (c) 2015 TradeIt. All rights reserved.
//

#import "TradeItInformationNeededResult.h"

@interface TradeItSecurityQuestionResult : TradeItInformationNeededResult

@property (copy) NSString* securityQuestion;
@property (copy) NSArray<Optional>* securityQuestionOptions; //nil if broker does not provide options
@property (copy) NSString<Optional>* challengeImage; //nil if broker does not provide challenge image

@end
