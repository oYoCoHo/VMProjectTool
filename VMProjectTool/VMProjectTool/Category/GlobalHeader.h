//
//  GlobalHeader.h
//  VMProjectTool
//
//  Created by yech on 2024/6/5.
//

#ifndef GlobalHeader_h
#define GlobalHeader_h

/// 是否主队列
static inline BOOL is_main_queue() {
    return dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL) == dispatch_queue_get_label(dispatch_get_main_queue());
}
/// 在主队列执行
static inline void dispatch_async_main_queue(_Nonnull dispatch_block_t block) {
    if (is_main_queue()) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}
/// 在子队列执行
static inline void dispatch_async_global_queue(_Nonnull dispatch_block_t block) {
    if (is_main_queue()) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
    } else {
        block();
    }
}
/// 同步主队列执行
static inline void dispatch_sync_main_queue(_Nonnull dispatch_block_t block) {
    if (is_main_queue()) {
        block();
    } else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}

///// 发送通知
//static inline void sendNotification(NSNotificationName _Nonnull notiName,_Nullable id obj) {
//    [[NSNotificationCenter defaultCenter] postNotificationName:notiName object:obj];
//}
//
/////  主线程发送通知
//static inline void sendNotificationOnMainThread(NSNotificationName _Nonnull notiName,_Nullable id obj) {
//    dispatch_async_main_queue(^{
//        sendNotification(notiName, obj);
//    });
//}

/// 加锁
static inline void YX_LOCK(dispatch_semaphore_t _Nullable lock) {
    if(lock) dispatch_semaphore_wait(lock, DISPATCH_TIME_FOREVER);
}

///解锁
static inline void YX_UNLOCK(dispatch_semaphore_t _Nullable lock) {
    if(lock) dispatch_semaphore_signal(lock);
}

///// 延时后主队列执行
//static inline void dispatch_after_main_queue(NSTimeInterval time, _Nonnull dispatch_block_t block) {
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
//}
//
///// 延时后子队列执行
//static inline void dispatch_after_global_queue(NSTimeInterval time, _Nonnull dispatch_block_t block) {
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
//}



static inline UIFont *FontSystem(CGFloat size) {
    return [UIFont systemFontOfSize:size];
}

/// PingFangSC Medium font
static inline UIFont *FontPingFangSCMedium(CGFloat size) {
    return [UIFont fontWithName:PingFangSCMediumFont size:size];
}

/// PingFangSC Regular font
static inline UIFont *FontPingFangSCRegular(CGFloat size) {
    return [UIFont fontWithName:PingFangSCRegularFont size:size];
}

/// PingFangSC Bold font
static inline UIFont *FontPingFangSCBold(CGFloat size) {
    return [UIFont fontWithName:PingFangSCBoldFont size:size];
}

/// YuanTiSC Bold font
static inline UIFont *FontYuanTiSCBold(CGFloat size) {
    return [UIFont fontWithName:YuanTiSCBoldFont size:size];
}

/// DIN Medium font
static inline UIFont *FontDINMedium(CGFloat size) {
    return [UIFont fontWithName:DINMediumFont size:size];
}

/// DIN Bold font
static inline UIFont *FontDINBold(CGFloat size) {
    return [UIFont fontWithName:DINBoldFont size:size];
}

#endif /* GlobalHeader_h */
