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
@property (copy) NSString<Optional>* informationShortMessage;
@property (copy) NSString<Optional>* informationLongMessage;
@property (copy) NSArray<Optional>* errorFields;

@end
