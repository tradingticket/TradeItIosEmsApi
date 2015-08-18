//
//  TradeItInformationNeededResult.h
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/26/15.
//  Copyright (c) 2015 TradeIt. All rights reserved.
//

#import "TradeItResult.h"

@interface TradeItInformationNeededResult : TradeItResult
@property (copy) NSString* informationType;
@property (copy) NSString<TIEMSOptional>* informationShortMessage;
@property (copy) NSString<TIEMSOptional>* informationLongMessage;
@property (copy) NSArray<TIEMSOptional>* errorFields;

@end
