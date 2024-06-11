//
//  YXChatVipMemberModel.m
//  ShiMiDa
//
//  Created by guotaihan on 2023/2/1.
//

#import "YXChatVipMemberModel.h"
#import "Friend.h"
#import "GroupMember.h"
#import "YXChatBaseMessage.h"
#import "YXShareMessageCellModel.h"
#import "YXGroupHornMessageInfo.h"
#import "YXChatGroupApplyModel.h"
#import "YXSFFriendModel.h"
#import "YXGlobalRankingListCellModel.h"
#import "YXBlackListCellModel.h"
@implementation YXChatVipMemberModel

+ (YXChatVipMemberModel*)getVipMemberWithModel:(id)model {
    YXChatVipMemberModel *vipModel = [YXChatVipMemberModel new];
    if ([model isKindOfClass:[YXChatBaseMessage class]]) {
        YXChatBaseMessage *chatMessage = model;
        vipModel.is_beautiful = [chatMessage.is_beautiful_name isEqualToString:@"1"];
        vipModel.vip_type = chatMessage.vip_type.intValue;
        vipModel.is_real = [chatMessage.is_real isEqualToString:@"1"];
        vipModel.string = chatMessage.fromName;
        vipModel.vip_honor_type = chatMessage.vip_honor_type.integerValue;
        vipModel.celebrity_ranking = chatMessage.celebrity_ranking;
        vipModel.svip_level = chatMessage.svip_level;
        return vipModel;
    }
    else if ([model isKindOfClass:[Friend class]]) {
        Friend *friend = model;
        vipModel.is_beautiful = [friend.is_beautiful_name isEqualToString:@"1"];
        vipModel.vip_type = friend.vip_type.intValue;
        vipModel.is_real = [friend.is_real isEqualToString:@"1"];
        vipModel.string = friend.showName;
        vipModel.vip_honor_type = friend.vip_honor_type.integerValue;
        vipModel.celebrity_ranking = friend.celebrity_ranking;
        vipModel.svip_level = friend.svip_level;
        return vipModel;
    }
    else if ([model isKindOfClass:[GroupMember class]]) {
        GroupMember *groupMember = model;
        vipModel.is_beautiful = [groupMember.is_beautiful_name isEqualToString:@"1"];
        vipModel.vip_type = groupMember.vip_type.intValue;
        vipModel.is_real = [groupMember.is_real isEqualToString:@"1"];
        vipModel.string = groupMember.showName;
        vipModel.vip_honor_type = groupMember.vip_honor_type.intValue;
        vipModel.celebrity_ranking = groupMember.celebrity_ranking;
        vipModel.svip_level = groupMember.svip_level;
        return vipModel;
    }
    else if ([model isKindOfClass:[GroupInfo class]]) {
        GroupInfo *groupInfo = model;
        vipModel.is_beautiful = [groupInfo.is_pretty isEqualToString:@"1"];
        vipModel.string = groupInfo.groupname;
        
        return vipModel;
    }
    else if ([model isKindOfClass:[YXShareMessageCellModel class]]) {
        YXShareMessageCellModel *cellModel = model;
        vipModel.is_beautiful = [cellModel.is_beautiful_name isEqualToString:@"1"];
        vipModel.vip_type = cellModel.vip_type.intValue;
        vipModel.is_real = [cellModel.is_real isEqualToString:@"1"];
        vipModel.vip_honor_type = cellModel.vip_honor_type.integerValue;
        vipModel.celebrity_ranking = cellModel.celebrity_ranking;
        vipModel.svip_level = cellModel.svip_level;
        vipModel.string = cellModel.title;
        return vipModel;
    }
    else if ([model isKindOfClass:[YXBatchSelectTargetModel class]]) {
        YXBatchSelectTargetModel *cellModel = model;
        vipModel.is_beautiful = [cellModel.is_beautiful_name isEqualToString:@"1"];
        vipModel.vip_type = cellModel.vip_type.intValue;
        vipModel.is_real = [cellModel.is_real isEqualToString:@"1"];
        vipModel.vip_honor_type = cellModel.vip_honor_type.integerValue;
        vipModel.celebrity_ranking = cellModel.celebrity_ranking;
        vipModel.svip_level = cellModel.svip_level;
        vipModel.string = cellModel.title;
        return vipModel;
    } else if ([model isKindOfClass:[YXUserInfo class]]) {
        YXUserInfo *infoModel = model;
        vipModel.is_beautiful = infoModel.is_beautiful_name;
        vipModel.vip_type = infoModel.vip_type;
        vipModel.is_real = infoModel.real_info ? infoModel.real_info.is_real : infoModel.is_real;
        vipModel.vip_honor_type = infoModel.vip_honor_type;
        vipModel.string = infoModel.nickname;
        vipModel.celebrity_ranking = infoModel.celebrity_ranking;
        vipModel.svip_level = infoModel.svip_level;
        if (infoModel.svip_info) {
            vipModel.svip_level = infoModel.svip_info.svip_level;
        }
        
        vipModel.string = infoModel.nickname;
        return vipModel;
    }
    else if ([model isKindOfClass:[YXGroupHornMessageInfo class]]) {
        YXGroupHornMessageInfo *hornModel = model;
        vipModel.is_beautiful = [hornModel.is_beautiful_name isEqualToString:@"1"] ? YES : NO;
        vipModel.vip_type = hornModel.vip_type.integerValue;
        vipModel.is_real = [hornModel.is_real isEqualToString:@"1"];
        vipModel.vip_honor_type = hornModel.vip_honor_type.integerValue;
        vipModel.celebrity_ranking = hornModel.celebrity_ranking;
        vipModel.svip_level = hornModel.svip_level;
        vipModel.string = hornModel.nickname;
        return vipModel;
    }
    else if ([model isKindOfClass:[YXChatGroupApplyModel class]]) {
        YXChatGroupApplyModel *applyModel = model;
        vipModel.is_beautiful = [applyModel.is_beautiful_name isEqualToString:@"1"] ? YES : NO;
        vipModel.vip_type = applyModel.vip_type;
        vipModel.is_real = [applyModel.is_real isEqualToString:@"1"];
        vipModel.vip_honor_type = applyModel.vip_honor_type;
        vipModel.string = applyModel.nickname;
        vipModel.celebrity_ranking = applyModel.celebrity_ranking;
        vipModel.svip_level = applyModel.svip_level;
        return vipModel;
    }
    
    else if ([model isKindOfClass:[YXSFFriendModel class]]) {
        YXSFFriendModel *cellModel = model;
        vipModel.is_beautiful = [cellModel.is_beautiful_name isEqualToString:@"1"] ? YES : NO;
        vipModel.vip_type = cellModel.vip_type.integerValue;
        vipModel.is_real = cellModel.is_real == 1 ? YES : NO;
        vipModel.vip_honor_type = cellModel.vip_honor_type.integerValue;
        vipModel.string = cellModel.nickname;
        vipModel.celebrity_ranking = cellModel.celebrity_ranking;
        vipModel.svip_level = cellModel.svip_level;
        return vipModel;
    }
    else if ([model isKindOfClass:[YXGlobalRankingListCellModel class]]) {
        YXGlobalRankingListCellModel *cellModel = model;
        vipModel.is_beautiful = cellModel.is_beautiful_name;
        vipModel.vip_type = cellModel.vip_type;
//        vipModel.is_real = cellModel.is_real == 1 ? YES : NO;
        vipModel.vip_honor_type = cellModel.vip_honor_type;
        vipModel.string = cellModel.nickname;
        vipModel.celebrity_ranking = cellModel.celebrity_ranking;
        vipModel.svip_level = cellModel.svip_level;
        return vipModel;
    }
    else if ([model isKindOfClass:[YXBlackListCellModel class]]) {
        YXBlackListCellModel *cellModel = model;
        vipModel.is_beautiful = cellModel.is_beautiful;
        vipModel.vip_type = cellModel.vip_type;
        vipModel.is_real = cellModel.is_real == 1 ? YES : NO;
        vipModel.vip_honor_type = cellModel.vip_honor_type;
        vipModel.string = cellModel.nickname;
        vipModel.celebrity_ranking = cellModel.celebrity_ranking;
        vipModel.svip_level = cellModel.svip_level;
        return vipModel;
    }
    else {
        return nil;
    }
}

- (instancetype)init {
    if (self = [super init]) {
        self.font = YX_FontPingFangSCRegular(16);
    }
    
    return self;
}

- (NSMutableAttributedString *)nicknameLogoAttributedString {
    if (!_nicknameLogoAttributedString) {
        NSInteger  maxLength = 6;//最大个数
        NSInteger  maxWidth = kRate(160);//最大长度
        if (kScreenWidth == 320) {
            maxWidth = kRate(130);
        }
        if (self.nameMaxLength > 0) {
            maxLength = self.nameMaxLength;
        }
        if (self.nameMaxWidth > 0) {
            maxWidth = self.nameMaxWidth;
        }
        
        NSString *nameString = self.string;
        //处理超长名字
        CGSize size = [YXCommonMethod getTextSizeWithText:nameString width:kRate(190) font:self.font];
        NSInteger stringLengthCount = [nameString getStringCharacterLengthCount];//字符长度
        if (size.width > maxWidth && stringLengthCount > maxLength) {
            NSString *rangeString = [nameString substringCharacterSequenceToIndex:(maxLength - 1)];
            nameString = [NSString stringWithFormat:@"%@...",rangeString];
        }
        
        //富文本
        NSString *text = [NSString stringWithFormat:@"%@ ",nameString];
        if (self.q_id.length > 0 && !self.is_robot_manager) {
            text = [NSString stringWithFormat:@"%@ ID:%@ ",nameString,self.q_id];
        }
        NSMutableAttributedString *resultAttributedString = [[NSMutableAttributedString alloc] initWithString:text];
        if (self.searchKey.length > 0) {//搜索
            NSArray *rangeArra = [text getRangeOfSubstring:self.searchKey];
            resultAttributedString = [NSString getAttributedKeyStringWithString:text heightStateRanges:rangeArra heightColor:UIColor.color_3486FF];
        } else {
            UIColor *titleColor = [YXProjectMethod getUserNameIdentificationColorWithModel:self  normalColor:UIColor.color_01071A];
            if (self.nameColor) {
                titleColor = self.nameColor;
            }

            [resultAttributedString addAttribute:NSForegroundColorAttributeName value:titleColor range:NSMakeRange(0, text.length)];
            
            if (self.font) {
                [resultAttributedString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, text.length)];
            }
            
        }
        
        self.nicknameLogoAttributedString = resultAttributedString;
    }
    
    return _nicknameLogoAttributedString;
}

- (NSMutableAttributedString *)groupnameLogoAttributedString {
    if (!_groupnameLogoAttributedString) {
        NSInteger  maxLength = 6;//最大个数
        NSInteger  maxWidth = kRate(160);//最大长度
        if (kScreenWidth == 320) {
            maxWidth = kRate(130);
        }
        if (self.nameMaxLength > 0) {
            maxLength = self.nameMaxLength;
        }
        if (self.nameMaxWidth > 0) {
            maxWidth = self.nameMaxWidth;
        }
        
        NSString *nameString = self.string;
        //处理超长名字
        CGSize size = [YXCommonMethod getTextSizeWithText:nameString width:kRate(100) font:self.font];
        NSInteger stringLengthCount = [nameString getStringCharacterLengthCount];//字符长度
        if (size.width > maxWidth || stringLengthCount > maxLength) {
            NSString *rangeString = [nameString substringCharacterSequenceToIndex:(maxLength - 1)];
            nameString = [NSString stringWithFormat:@"%@...",rangeString];
        }
        
        
        
        
        NSString *text = [NSString stringWithFormat:@"%@ ",nameString];
        NSMutableAttributedString *resultAttributedString = [[NSMutableAttributedString alloc] initWithString:text];
        if (self.searchKey.length > 0) {//搜索
            NSArray *rangeArra = [text getRangeOfSubstring:self.searchKey];
            resultAttributedString = [NSString getAttributedKeyStringWithString:text heightStateRanges:rangeArra heightColor:UIColor.color_3486FF];
        } else {
            UIColor *titleColor = [UIColor colorWithHexString:@"#01071A"];
            [resultAttributedString addAttribute:NSForegroundColorAttributeName value:titleColor range:NSMakeRange(0, text.length)];
            
            if (self.font) {
                [resultAttributedString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, text.length)];
            }
        }
        
        _groupnameLogoAttributedString = resultAttributedString;
    }
    
    return _groupnameLogoAttributedString;
}


#pragma mark 获取昵称富文本
- (NSMutableAttributedString *)getTitleNameAttributedString {
    return self.isGroup ? self.groupnameLogoAttributedString : self.nicknameLogoAttributedString;
}



#pragma mark 获取昵称中的VIP标识
- (NSObject*)getVipLogoImage {
    
    UIImage *vipimage = nil;
    if (self.vip_type == 1) {
        vipimage = [UIImage makeVipIcon:VipLevelTypeVip];
    }
    else if (self.vip_type == 2 && self.vip_honor_type == 0) {
        vipimage = [UIImage makeVipIcon:VipLevelTypeSvip];
        if (self.svip_level == 1) {
            vipimage = [UIImage makeVipIcon:VipLevelTypeSvip1];
        } else if (self.svip_level == 2) {
            vipimage = [UIImage makeVipIcon:VipLevelTypeSvip2];
        } else if (self.svip_level == 3) {
            vipimage = [UIImage makeVipIcon:VipLevelTypeSvip3];
        } else if (self.svip_level == 4) {
            vipimage = [UIImage makeVipIcon:VipLevelTypeSvip4];
        } else if (self.svip_level == 5) {
            vipimage = [UIImage makeVipIcon:VipLevelTypeSvip5];
        } else if (self.svip_level == 6) {
            vipimage = [UIImage makeVipIcon:VipLevelTypeSvip6];
        } else if (self.svip_level == 7) {
            vipimage = [UIImage makeVipIcon:VipLevelTypeSvip7];
        } else if (self.svip_level == 8) {
            vipimage = [UIImage makeVipIcon:VipLevelTypeSvip8];
        } else if (self.svip_level == 9) {
            vipimage = [UIImage makeVipIcon:VipLevelTypeSvip9];
        }
    }
    else if (self.vip_type == 2 || self.vip_honor_type > 0) {
        vipimage = [UIImage makeVipIcon:VipLevelTypeSvip];
        if (self.vip_honor_type == 3) {
            vipimage = [UIImage makeVipIcon:VipLevelTypeGold];
        } else if (self.vip_honor_type == 4) {
            vipimage = [UIImage makeVipIcon:VipLevelTypePlatinum];
        } else if (self.vip_honor_type == 5) {
            vipimage = [UIImage makeVipIcon:VipLevelTypeDiamond];
        } else if (self.vip_honor_type == 7) {
            vipimage = [UIImage makeVipIcon:VipLevelTypeGoldDiamond];
        } else {}
    }
    
    
    return vipimage;
}

#pragma mark 获取荣誉会员标识
- (NSObject*)getVipHonorImage {
    UIImage *vipimage = [UIImage makeVipIcon:VipLevelTypeGold];
    if (self.vip_honor_type == 3) {
        vipimage = [UIImage makeVipIcon:VipLevelTypeGold];
    } else if (self.vip_honor_type == 4) {
        vipimage = [UIImage makeVipIcon:VipLevelTypePlatinum];
    } else if (self.vip_honor_type == 5) {
        vipimage = [UIImage makeVipIcon:VipLevelTypeDiamond];
    } else if (self.vip_honor_type == 7) {
        vipimage = [UIImage makeVipIcon:VipLevelTypeGoldDiamond];
    } else {}
    
    return vipimage;
}

#pragma mark 获取vip/svip会员标识
- (NSObject*)getVipSvipImage {
    UIImage *vipimage = nil;
    if (self.vip_type == 1) {
        vipimage = [UIImage makeVipIcon:VipLevelTypeVip];
    } else if (self.vip_type == 2) {
        vipimage = [UIImage makeVipIcon:VipLevelTypeSvip];
        if (self.svip_level == 1) {
            vipimage = [UIImage makeVipIcon:VipLevelTypeSvip1];
        } else if (self.svip_level == 2) {
            vipimage = [UIImage makeVipIcon:VipLevelTypeSvip2];
        } else if (self.svip_level == 3) {
            vipimage = [UIImage makeVipIcon:VipLevelTypeSvip3];
        } else if (self.svip_level == 4) {
            vipimage = [UIImage makeVipIcon:VipLevelTypeSvip4];
        } else if (self.svip_level == 5) {
            vipimage = [UIImage makeVipIcon:VipLevelTypeSvip5];
        } else if (self.svip_level == 6) {
            vipimage = [UIImage makeVipIcon:VipLevelTypeSvip6];
        } else if (self.svip_level == 7) {
            vipimage = [UIImage makeVipIcon:VipLevelTypeSvip7];
        } else if (self.svip_level == 8) {
            vipimage = [UIImage makeVipIcon:VipLevelTypeSvip8];
        } else if (self.svip_level == 9) {
            vipimage = [UIImage makeVipIcon:VipLevelTypeSvip9];
        }
    }
    
    
    return vipimage;
}

#pragma mark 获取昵称中的靓号标识
- (NSObject*)getBeautifulLogoImage {
    UIImage *image = self.isGroup ? [YXMobileAppManager manager].beautyGroupAccountIconImage :  [YXMobileAppManager manager].beautyAccountIconImage;

    if (self.beautifulLogoImageName.length > 0) {
        image = [UIImage imageNamed:self.beautifulLogoImageName];
    }
    return image;
}

#pragma mark 获取昵称中的实名认证标识
- (NSObject*)getRealLogoImage {
    UIImage *realimage = [UIImage imageNamed:@"ic_renzheng"];
    
    return realimage;
}


#pragma mark 显示灰色靓号标识
- (void)configGrayBeautifulLogoImage {
    self.is_beautiful = YES;
    self.beautifulLogoImageName = @"ic_duihua_lianghao1";
}


@end
