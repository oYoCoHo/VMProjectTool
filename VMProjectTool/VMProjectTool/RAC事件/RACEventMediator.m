//
//  RACEventMediator.m
//  VMProjectTool
//
//  Created by yech on 2024/6/16.
//

#import "RACEventMediator.h"

@interface RACEventMediator ()



@end

@implementation RACEventMediator

+ (instancetype)sharedInstance {
    // 使用静态变量来保存唯一实例
    static RACEventMediator *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

// 防止通过alloc/init方式创建新的实例
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [self sharedInstance];
}

// 防止通过copy方式创建新的实例
- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (void)action {
//    NSDictionary *param = @{@"sender":self};
//    [[RACEventMediator sharedInstance].refreshDataSubject sendNext:param];
//    
//    [[RACEventMediator sharedInstance].refreshDataSubject subscribeNext:^(NSDictionary *param) {
//        NSObject *sender =  [param valueForKey:@"sender"];
//        
//        if (![sender isEqual:self]) {
//            return;
//        }
//    }];
    
    [[RACEventMediator sharedInstance] bindSender:[NSMutableArray array] toReceiver:[NSMutableArray array]];
    
    NSDictionary *param = @{@"sender":@"123"};
    [[RACEventMediator sharedInstance].refreshDataSubject sendNextWithSender:self value:param];
    
    [[RACEventMediator sharedInstance].refreshDataSubject receiveWithReceiver:self nextBlock:^(id  _Nonnull x) {
            
    }];
    
    [[RACEventMediator sharedInstance].refreshDataSubject receiveNextWithReceiver:self nextBlock:^(id  _Nonnull x) {
            
    }];
    [[RACEventMediator sharedInstance].refreshDataSubject subscribeWithReceiver:self nextBlock:^(NSDictionary *param) {
            
    }];
}

//- (void)p_sendNext:(id)value {
//    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:@{@"sender":self}];
//    [param setValue:value forKey:@"value"];
//    
//    [[RACEventMediator sharedInstance].refreshDataSubject sendNext:param];
//}
//
//- (RACDisposable *)p_subscribeNext:(void (^)(id x))nextBlock {
//    return [[RACEventMediator sharedInstance].refreshDataSubject subscribeNext:^(NSDictionary *param) {
//        NSObject *sender =  [param valueForKey:@"sender"];
//        
//        if (![sender isEqual:self]) {
//            return;
//        }
//        
//        id value =  [param valueForKey:@"value"];
//        if (nextBlock) {
//            nextBlock(value);
//        }
//    }];
//}

#pragma mark 通用方法
- (void)bindSender:(id)sender toReceiver:(id)receiver {
    EventBindModel *model = [[RACEventMediator sharedInstance].senderReceiverMap objectForKey:sender];
    if (!model) {
        model = [EventBindModel new];
        [model.receiverArray addPointer:(__bridge void *)receiver];
    } else {
        if ([model isReceiver:receiver]) {
            [model.receiverArray addPointer:(__bridge void *)receiver];
        }
    }
    
    [self.senderReceiverMap setObject:model forKey:sender];
}




@end


@implementation EventSubject

- (void)sendWithSender:(id)sender value:(id)value {
    [self sendNextWithSender:sender value:value];
}

- (void)sendNextWithSender:(id)sender value:(id)value {
    NSMutableDictionary *param = [NSMutableDictionary dictionaryWithDictionary:@{@"sender":sender}];
    [param setValue:value forKey:@"value"];
    
    [self sendNext:param];
}

- (void)receiveWithReceiver:(id)receiver nextBlock:(void (^)(id x))nextBlock {
    [self subscribeWithReceiver:receiver nextBlock:nextBlock];
}

- (void)receiveNextWithReceiver:(id)receiver nextBlock:(void (^)(id x))nextBlock {
    [self subscribeWithReceiver:receiver nextBlock:nextBlock];
}


- (void)subscribeWithReceiver:(id)receiver nextBlock:(void (^)(id x))nextBlock {

    [self subscribeNext:^(NSMutableDictionary *param) {
        id sender = [param valueForKey:@"sender"];
        id value = [param valueForKey:@"value"];
        
        EventBindModel *model = [[RACEventMediator sharedInstance].senderReceiverMap objectForKey:sender];
        if (![model isReceiver:receiver]) {
            return;
        }
        
        if (nextBlock) {
            nextBlock(value);
        }
    }];
}


- (RACDisposable *)p_subscribeNext:(void (^)(id x))nextBlock {
    return [[RACEventMediator sharedInstance].refreshDataSubject subscribeNext:^(NSDictionary *param) {
        NSObject *sender =  [param valueForKey:@"sender"];
        
        if (![sender isEqual:self]) {
            return;
        }
        
        id value =  [param valueForKey:@"value"];
        if (nextBlock) {
            nextBlock(value);
        }
    }];
}

@end

@implementation EventBindModel

- (BOOL)isReceiver:(id)receiver {
    BOOL value = NO;
    for (int i=0; i < self.receiverArray.count; i++) {
        NSObject *map_receiver = (__bridge NSObject *)[self.receiverArray pointerAtIndex:i];
        if (map_receiver == receiver) {
            value = YES;
            break;
        }
    }

    
    return value;
}

- (NSPointerArray *)receiverArray {
    if (!_receiverArray) {
        _receiverArray = [NSPointerArray pointerArrayWithOptions:NSPointerFunctionsObjectPointerPersonality];;
    }
    
    return _receiverArray;
}
@end
