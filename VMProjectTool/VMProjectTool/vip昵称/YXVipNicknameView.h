//
//  YXVipNicknameView.h
//  ShiMiDa
//
//  Created by yy on 2023/9/6.
//

#import <UIKit/UIKit.h>
#import "YXChatVipMemberModel.h"
#import "YXCustomLotAnimationView.h"
#import "YXBaseImageView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, YXVipNicknameViewContentMode) {
    YXVipNicknameViewContentModeLeft = 0,
    YXVipNicknameViewContentModeRight = 1
};

@interface YXVipNicknameView : UIView

@property (nonatomic,strong) YXBaseImageView *vipImageView;

@property (nonatomic,strong) YXBaseImageView *beautifulImageView;

@property (nonatomic,strong) YXBaseImageView *realImageView;

@property (nonatomic,strong) YXCustomLotAnimationView *fameHallAnimationView;


@property (nonatomic,strong) UIStackView *stackView;

@property (nonatomic,copy) NSString *title;

@property (nonatomic,strong) UIColor *titleColor;

@property (nonatomic,strong) UIFont *titleFont;

@property (nonatomic,copy)  NSAttributedString *titleAttributedText;

@property (nonatomic,assign) YXVipNicknameViewContentMode contentMode;

- (void)configVipMemberModel:(YXChatVipMemberModel*)vipModel;

@end

NS_ASSUME_NONNULL_END
