//
//  YXVipNicknameView.m
//  ShiMiDa
//
//  Created by yy on 2023/9/6.
//

#import "YXVipNicknameView.h"

@interface YXVipNicknameView ()

@property (nonatomic,strong) UILabel *nameLabel;

@end


@implementation YXVipNicknameView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configSubview];
    }
    
    
    return self;
}

- (void)configSubview {
    
    [self.stackView addArrangedSubview:self.vipImageView];
    [self.stackView addArrangedSubview:self.beautifulImageView];
    [self.stackView addArrangedSubview:self.realImageView];
    [self.stackView addArrangedSubview:self.fameHallAnimationView];
    
    //默认750
    [self.nameLabel setContentCompressionResistancePriority:745 forAxis:UILayoutConstraintAxisHorizontal];
//    [self.nameLabel setContentHuggingPriority:255 forAxis:UILayoutConstraintAxisHorizontal];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self);
        make.right.lessThanOrEqualTo(self.stackView.mas_left);
        make.height.equalTo(self);
    }];
    
    [self.stackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.height.equalTo(self);
        make.right.equalTo(self);
        make.left.equalTo(self.nameLabel.mas_right);
    }];
    
    [self.fameHallAnimationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.stackView);
        make.width.equalTo(self.fameHallAnimationView.mas_height).multipliedBy(27.0/22);
        make.height.mas_equalTo(18);
    }];
}

- (void)configVipMemberModel:(YXChatVipMemberModel*)vipModel {
    if (vipModel.ranking_page_type == 1) {
        [self configRankingPageWithModel:vipModel];
        return;
    }
    
    self.vipImageView.hidden = (vipModel.vip_type > 0 || vipModel.vip_honor_type > 0) ? NO : YES;
    if (vipModel.ranking_page_type == 2) {//全球排行榜，显示除会员外的其他标识
        self.vipImageView.hidden = YES;
    }
    
    self.beautifulImageView.hidden = vipModel.is_beautiful ? NO : YES;
    self.realImageView.hidden = vipModel.is_real ? NO : YES;
    self.fameHallAnimationView.hidden = vipModel.celebrity_ranking > 0 ? NO : YES;
    
    self.vipImageView.image = (UIImage*)[vipModel getVipLogoImage];
    self.beautifulImageView.image = (UIImage*)[vipModel getBeautifulLogoImage];
    self.realImageView.image = (UIImage*)[vipModel getRealLogoImage];
    
    
    self.nameLabel.attributedText = [vipModel getTitleNameAttributedString];
    

    [self.fameHallAnimationView play];
}

- (void)configRankingPageWithModel:(YXChatVipMemberModel*)vipModel {
    for (UIView *subviews in self.stackView.arrangedSubviews) {
        subviews.hidden = YES;
    }
//    self.vipImageView.hidden = vipModel.vip_type > 0 ? NO : YES;
//    self.beautifulImageView.hidden = vipModel.vip_honor_type > 0 ? NO : YES;
    self.vipImageView.hidden = vipModel.vip_honor_type > 0 ? NO : YES;
    self.beautifulImageView.hidden = vipModel.vip_type > 0 ? NO : YES;
    
    self.vipImageView.image = (UIImage*)[vipModel getVipHonorImage];
    self.beautifulImageView.image = (UIImage*)[vipModel getVipSvipImage];
}


- (void)setTitle:(NSString *)title {
    _title = title;
    
    self.nameLabel.text = title;
    
    //重置回默认状态，防止视图复用
    self.nameLabel.textColor = self.tintColor ? self.titleColor : UIColor.color_01071A;
    self.nameLabel.font = self.titleFont ? self.titleFont : YX_FontPingFangSCRegular(14);
    self.vipImageView.hidden =  YES;
    self.beautifulImageView.hidden =  YES;
    self.realImageView.hidden =  YES;
    self.fameHallAnimationView.hidden =  YES;
}

- (void)setTitleColor:(UIColor *)titleColor {
    _titleColor = titleColor;
    
    self.nameLabel.textColor = titleColor;
}

- (void)setTitleAttributedText:(NSAttributedString *)titleAttributedText {
    _titleAttributedText = titleAttributedText;
    
    self.nameLabel.attributedText = titleAttributedText;
}

- (void)setContentMode:(YXVipNicknameViewContentMode)contentMode {
    _contentMode = contentMode;
    
    if (contentMode == YXVipNicknameViewContentModeLeft) {
        self.nameLabel.textAlignment = NSTextAlignmentLeft;
        [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self);
            make.right.lessThanOrEqualTo(self.stackView.mas_left);
            make.height.equalTo(self);
        }];
        
        [self.stackView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.height.equalTo(self);
            make.right.equalTo(self);
            make.left.equalTo(self.nameLabel.mas_right);
        }];
    } else if (contentMode == YXVipNicknameViewContentModeRight) {
        [self.stackView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self);
            make.height.equalTo(self);

        }];
        
        self.nameLabel.textAlignment = NSTextAlignmentRight;
        [self.nameLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self.stackView.mas_left).offset(kRate(-5));
            make.height.equalTo(self);
//            make.left.mas_lessThanOrEqualTo(0);
        }];
    }
}


#pragma mark 懒加载
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel initLabelWithText:@"" textColor:UIColor.color_01071A font:YX_FontPingFangSCRegular(14)];
        
        [self addSubview:_nameLabel];
    }
    
    return _nameLabel;
}

- (UIStackView *)stackView {
    if (!_stackView) {
        _stackView = [[UIStackView alloc] init];
        _stackView.axis = UILayoutConstraintAxisHorizontal;
        _stackView.alignment = UIStackViewAlignmentCenter;

        
        [self addSubview:_stackView];
    }
    
    return _stackView;
}

- (YXBaseImageView *)vipImageView {
    if (!_vipImageView) {
        _vipImageView = [YXBaseImageView new];
        _vipImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    return _vipImageView;
}

- (YXBaseImageView *)beautifulImageView {
    if (!_beautifulImageView) {
        _beautifulImageView = [YXBaseImageView new];
        _beautifulImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    return _beautifulImageView;
}

- (YXBaseImageView *)realImageView {
    if (!_realImageView) {
        _realImageView = [YXBaseImageView new];
        _realImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    return _realImageView;
}

- (YXCustomLotAnimationView *)fameHallAnimationView {
    if (!_fameHallAnimationView) {
        NSString *mainBundlePath = [[NSBundle mainBundle] pathForResource:@"fame_hall_icon" ofType:@"bundle"];
        NSBundle *mainBundle = [NSBundle bundleWithPath:mainBundlePath];
        _fameHallAnimationView = [YXCustomLotAnimationView animationWithFilePath:[mainBundle pathForResource:@"data" ofType:@"json"]];
        
        _fameHallAnimationView.loopAnimation = YES;
        
        //添加了子视图后，fameHallAnimationView的addTapGes才生效
        UIView *actionView = [UIView new];
        [_fameHallAnimationView addSubview:actionView];
        [actionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_fameHallAnimationView);
        }];
    }
    
    return _fameHallAnimationView;
}
@end
