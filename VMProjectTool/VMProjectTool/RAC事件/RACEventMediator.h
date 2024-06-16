//
//  RACEventMediator.h
//  VMProjectTool
//
//  Created by yech on 2024/6/16.
//

#import <Foundation/Foundation.h>
#import "ReactiveObjC/ReactiveObjC.h"

NS_ASSUME_NONNULL_BEGIN

@class EventSubject;

@interface RACEventMediator : NSObject

+ (instancetype)sharedInstance;

- (void)bindSender:(id)sender toReceiver:(id)receiver;

// 存储发送者和接收者的映射关系
@property (nonatomic,strong) NSMapTable<id, id> *senderReceiverMap;

@property (nonatomic,strong) EventSubject *refreshDataSubject;

@property (nonatomic,strong) EventSubject *updateViewSubject;

@end


@interface EventSubject : RACSubject

- (void)sendWithSender:(id)sender value:(id)value;
- (void)receiveWithReceiver:(id)receiver nextBlock:(void (^)(id x))nextBlock;

- (void)sendNextWithSender:(id)sender value:(id)value;

- (void)subscribeWithReceiver:(id)receiver nextBlock:(void (^)(id x))nextBlock;
- (void)receiveNextWithReceiver:(id)receiver nextBlock:(void (^)(id x))nextBlock;

@end



@interface EventBindModel : NSObject

@property (nonatomic,weak) NSObject *sender;

@property (nonatomic,strong) RACSubject *subject;


@property (nonatomic,strong) NSPointerArray *receiverArray;

- (BOOL)isReceiver:(id)receiver;

@end

NS_ASSUME_NONNULL_END
