//
//  TradeItInformationNeededResult.m
//  TradeItIosEmsApi
//
//  Created by Serge Kreiker on 6/26/15.
//  Copyright (c) 2015 TradeIt. All rights reserved.
//

#import "TradeItInformationNeededResult.h"

@implementation TradeItInformationNeededResult

- (id) init{
    
    self = [super init];
    
    if(self){
        self.informationShortMessage = nil;
        self.informationLongMessage = nil;
        self.errorFields = nil;
    }
    return self;
}

- (NSString*) description{
    return [NSString stringWithFormat:@"%@ informationShortMessage=%@ informationLongMessage=%@ errorFields=%@",[super description], self.informationShortMessage,self.informationLongMessage,self.errorFields ];
}

@end
