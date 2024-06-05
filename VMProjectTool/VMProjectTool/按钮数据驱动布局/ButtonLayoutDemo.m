//
//  ButtonLayoutDemo.m
//  VMProjectTool
//
//  Created by yech on 2024/6/5.
//

#import "ButtonLayoutDemo.h"
#import "UIButton+SHExtension.h"
#import "UIKit/UIKey.h"
#import "GlobalHeader.h"
#import "UIColor+Extension.h"

@interface ButtonLayoutDemo ()

@property (nonatomic,strong) UIButton *headerButton;

@property (nonatomic,strong) UIView *bgView;
@end

@implementation ButtonLayoutDemo


- (void)initSubviews {
    //头部视图顺序：headerButton headerTime headerArrow
    [self.headerButton.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
    }];
    [self.headerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.top.equalTo(@18);
        
        make.left.equalTo(self.headerButton.imageView.mas_left);
        make.right.equalTo(self.headerButton.titleLabel.mas_right);
        make.top.equalTo(self.headerButton.titleLabel.mas_top);
        make.bottom.equalTo(self.headerButton.titleLabel.mas_bottom);
        make.right.lessThanOrEqualTo(self.headerTime.mas_left).offset(-12);
        make.right.lessThanOrEqualTo(self.headerArrow.mas_left).offset(-24);
    }];
}

- (void)changeValueAction {
    [self.headerButton setTitle:@"asldfjaksdjfkasjdfkajdklfjalskdjfalksdjfaskdjflksfj" forState:UIControlStateNormal];
    
    // 无图片时
    [self.headerButton setImage:nil forState:UIControlStateNormal];
    [self headerButtonLayoutPriorityWithIsImageShow:NO];
    
    
    // 有图片时
    [self.headerButton setImage:[UIImage imageNamed:@"workHeader"] forState:UIControlStateNormal];
    [self headerButtonLayoutPriorityWithIsImageShow:YES];
}

- (void)headerButtonLayoutPriorityWithIsImageShow:(BOOL)isImageShow {
    
    if (isImageShow) {
        [self.headerButton.imageView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self.headerButton.titleLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
    } else {
        [self.headerButton.imageView setContentCompressionResistancePriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
        [self.headerButton.titleLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    }
    
    [self.headerTime setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
}

- (UIButton *)headerButton {
    if (!_headerButton) {
        _headerButton = [UIButton initButtonWithTitle:@"公告" titleColor:[UIColor colorWithHexString:@"#262A33" alpha:1] titleFont:FontPingFangSCBold(15) image:[UIImage imageNamed:@"workHeader"]];
        _headerButton.adjustsImageWhenHighlighted = NO;
        _headerButton.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);// 图片和标题间距
        _headerButton.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        
        [self.bgView addSubview:_headerButton];
    }
    
    return _headerButton;
}
@end
