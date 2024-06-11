//
//  YXChatVipMemberModel.h
//  ShiMiDa
//
//  Created by guotaihan on 2023/2/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXChatVipMemberModel : NSObject

///字体
@property (nonatomic,strong) UIFont *font;
///昵称颜色,如果有值，优先显示这里的颜色
@property (nonatomic,strong) UIColor *nameColor;
///名称最大个数
@property (nonatomic,assign) NSInteger nameMaxLength;
///名称最大宽度
@property (nonatomic,assign) NSInteger nameMaxWidth;
///名称
@property (nonatomic,copy) NSString *string;
///会员 无=0 普通会员=1 SVIP会员=2
@property (nonatomic,assign) NSInteger vip_type;
///荣誉会员 无=0 黄金会员=3 铂金会员=4 钻石会员=5，金钻会员=7
@property (assign, nonatomic) NSInteger vip_honor_type;
///是否靓号
@property (nonatomic,assign) BOOL is_beautiful;
///真人认证
@property (nonatomic,assign) BOOL is_real;
///事密达ID
@property (nonatomic,copy) NSString *q_id;
///是否群靓号
@property (nonatomic, copy) NSString *is_pretty;
///搜索key，需要高亮
@property (nonatomic,copy) NSString *searchKey;
///名人堂排名
@property (nonatomic,assign) NSInteger celebrity_ranking;
///是否群管家
@property (nonatomic,assign) BOOL is_robot_manager;
///svip等级
@property (assign, nonatomic) NSInteger svip_level;

///靓号标识名称
@property (nonatomic, copy) NSString *beautifulLogoImageName;

///是否单聊导航标题场景
@property (nonatomic,assign) BOOL isSingleChatNavTitle;
///撤回事件
@property (nonatomic, copy) void(^recallMessageActionBlock)(void);

///全球排行榜页面标识，1:只显示会员荣誉会员标识， 2:只显示除会员标识外的其他标识
@property (nonatomic,assign) NSInteger ranking_page_type;

+ (YXChatVipMemberModel*)getVipMemberWithModel:(id)model;


#pragma mark v4.4.0版本后模型跟YXVipNicknameView搭配使用，新增下面属性和方法

///用户昵称
@property (nonatomic, strong) NSMutableAttributedString *nicknameLogoAttributedString;
///群名称
@property (nonatomic, strong) NSMutableAttributedString *groupnameLogoAttributedString;
///是否是群
@property (nonatomic, assign) BOOL isGroup;

/// 获取昵称富文本
- (NSMutableAttributedString *)getTitleNameAttributedString;

///获取昵称中的VIP标识
- (NSObject*)getVipLogoImage;

/// 获取昵称中的靓号标识
- (NSObject*)getBeautifulLogoImage;

/// 获取昵称中的实名认证标识
- (NSObject*)getRealLogoImage;

/// 显示灰色靓号标识
- (void)configGrayBeautifulLogoImage;


/// 获取荣誉会员标识
- (NSObject*)getVipHonorImage;

/// 获取vip/svip会员标识
- (NSObject*)getVipSvipImage;

@end

NS_ASSUME_NONNULL_END
