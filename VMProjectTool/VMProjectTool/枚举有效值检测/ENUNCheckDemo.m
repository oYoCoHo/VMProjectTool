//
//  ENUNCheckDemo.m
//  VMProjectTool
//
//  Created by yech on 2024/6/5.
//

#import "ENUNCheckDemo.h"
#import "ENUN_Check.h"
@implementation ENUNCheckDemo

- (void)antion {
    
    [self checkENUNCardsType:vMWDetailCardsTypeData];
    [self checkENUNCardsType:6];
}

- (void)checkENUNCardsType:(vMWDetailCardsType)type {
    if (NS_ENUM_CHECK(vMWDetailCardsType, type)) {
        NSLog(@"vMWDetailCardsType 有效值:%lu",(unsigned long)type);
    } else {
        NSLog(@"vMWDetailCardsType 无效值:%lu",(unsigned long)type);
    }
}
@end
