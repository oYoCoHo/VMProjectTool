//
//  DashedView.m
//  demo
//
//  Created by yech on 2024/6/16.
//

#import "DashedView.h"

@interface DashedView ()

@property (nonatomic,strong) CAShapeLayer *shapeLayer;

@end

@implementation DashedView



//- (instancetype)initWithFrame:(CGRect)frame {
//    self = [super initWithFrame:frame];
//    if (self) {
//        [self setupDashedBorder];
//    }
//    return self;
//}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateDashedBorderPath];
}

- (void)setupDashedBorder {
    NSInteger lineWidth = self.lineWidth ? self.lineWidth : 2;
    NSInteger lineSpacing = self.lineSpacing ? self.lineSpacing : 2;
    CGColorRef strokeColor = self.dashedColor ? self.dashedColor.CGColor : [UIColor blackColor].CGColor;
    
    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.fillColor = [UIColor clearColor].CGColor;
    self.shapeLayer.strokeColor = strokeColor;
    self.shapeLayer.lineWidth = 1;
    self.shapeLayer.lineDashPattern = @[@(lineWidth), @(lineSpacing)]; // 设置虚线样式，第一个数字表示实线长度，第二个数字表示虚线长度
    [self.layer addSublayer:self.shapeLayer];
    [self updateDashedBorderPath];
}

- (void)updateDashedBorderPath {
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bounds];
    self.shapeLayer.path = path.CGPath;
}
@end
