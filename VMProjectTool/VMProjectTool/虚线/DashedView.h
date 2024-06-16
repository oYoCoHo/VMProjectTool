//
//  DashedView.h
//  demo
//
//  Created by yech on 2024/6/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DashedView : UIView

@property (nonatomic,strong) UIColor *dashedColor;

@property (nonatomic,assign) NSInteger lineSpacing;

@property (nonatomic,assign) NSInteger lineWidth;

- (void)setupDashedBorder;

@end

NS_ASSUME_NONNULL_END
