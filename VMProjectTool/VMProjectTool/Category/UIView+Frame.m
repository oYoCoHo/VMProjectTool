//
//  UIView+Frame.m
//
//
//  Created by apple on 15-3-5.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}


- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}


- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

/**
 设置任意圆角及边框(实线/虚线)
 
 @param corners 要设置的圆角位置集合
 @param radius 圆角半径
 @param lineWidth 边框宽度
 @param lineColor 边框颜色
 */
- (void)rounderWithCorners:(UIRectCorner)corners radius:(CGFloat)radius lineWidth:(CGFloat)lineWidth lineColor:(UIColor *_Nullable )lineColor {
    ///解决masonry布局获取不了正确的frame
    [self.superview layoutIfNeeded];
    
    [self.layer.sublayers enumerateObjectsUsingBlock:^(__kindof CALayer * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[CAShapeLayer class]] && idx == 0) {
            [obj removeFromSuperlayer];
            *stop = YES;
        }
    }];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius,radius)];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.lineWidth = lineWidth;
    borderLayer.strokeColor = lineColor.CGColor;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    borderLayer.path = maskPath.CGPath;
    [self.layer insertSublayer:borderLayer atIndex:0];
    //self.borderLayer = borderLayer;
    self.layer.mask = maskLayer;
}

#pragma mark 切部分边圆角
- (void)cornerRadiusByRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:cornerRadii];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

/// 获取当前 view 在 toView 中的绝对位置
- (CGRect)localToView:(UIView *)toView {
    return [self convertRect:self.bounds toView:toView];
}

/// 添加等宽子视图，视图间是否有间距
/// - Parameters:
///   - subViews: 需要添加的 views
///   - hasSpace: 视图间是否有间距
- (void)addEqualWidthSubViews:(NSArray<UIView *> *)subViews hasSpace:(BOOL)hasSpace {
    if (!subViews.count) return;
    
    UIView *tempSpaceView = nil;
    UIView *tempSubView = nil;
    
    for (UIView *subView in subViews) {
        [self addSubview:subView];

        [subView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(0);
        }];
        
        if (hasSpace) {
            UIView *spaceView = [UIView new];
            [self addSubview:spaceView];
            
            [spaceView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.mas_equalTo(0);
            }];
            
            if (tempSpaceView) {
                [spaceView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(tempSubView.mas_right);
                    make.width.equalTo(tempSpaceView);
                }];
            } else {
                [spaceView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.mas_equalTo(0);
                }];
            }
            
            [subView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(spaceView.mas_right);
            }];
            
            tempSpaceView = spaceView;
        } else {
            [subView mas_makeConstraints:^(MASConstraintMaker *make) {
                if (tempSubView) {
                    make.left.equalTo(tempSubView.mas_right);
                    make.width.equalTo(tempSubView);
                } else {
                    make.left.mas_equalTo(0);
                }
            }];
        }
        tempSubView = subView;
    }
    if (hasSpace) {
        UIView *spaceView = [UIView new];
        [self addSubview:spaceView];
        
        [spaceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.mas_equalTo(0);
            make.left.equalTo(tempSubView.mas_right);
            make.width.equalTo(tempSpaceView);
        }];
    } else {
        [tempSubView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
        }];
    }
}


#pragma mark 任意圆角
- (void)cornerRadiusWithRadius:(YXRadius)radius {
    CGFloat imgW = self.size.width;
    CGFloat imgH = self.size.height;
    UIBezierPath *path = [UIBezierPath bezierPath];
    //左下
    [path addArcWithCenter:CGPointMake(radius.downLeft, imgH - radius.downLeft) radius:radius.downLeft startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
    //左上
    [path addArcWithCenter:CGPointMake(radius.upLeft, radius.upLeft) radius:radius.upLeft startAngle:M_PI endAngle:M_PI_2 * 3 clockwise:YES];
    //右上
    [path addArcWithCenter:CGPointMake(imgW - radius.upRight, radius.upRight) radius:radius.upRight startAngle:M_PI_2 * 3 endAngle:0 clockwise:YES];
    //右下
    [path addArcWithCenter:CGPointMake(imgW - radius.downRight, imgH - radius.downRight) radius:radius.downRight startAngle:0 endAngle:M_PI_2 clockwise:YES];
    [path closePath];
    [path addClip];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = path.CGPath;
    self.layer.mask = maskLayer;
}

- (CAShapeLayer *)cornerRadiusShapeLayerWithRadius:(YXRadius)radius {
    CGFloat imgW = self.size.width;
    CGFloat imgH = self.size.height;
    UIBezierPath *path = [UIBezierPath bezierPath];
    //左下
    [path addArcWithCenter:CGPointMake(radius.downLeft, imgH - radius.downLeft) radius:radius.downLeft startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
    //左上
    [path addArcWithCenter:CGPointMake(radius.upLeft, radius.upLeft) radius:radius.upLeft startAngle:M_PI endAngle:M_PI_2 * 3 clockwise:YES];
    //右上
    [path addArcWithCenter:CGPointMake(imgW - radius.upRight, radius.upRight) radius:radius.upRight startAngle:M_PI_2 * 3 endAngle:0 clockwise:YES];
    //右下
    [path addArcWithCenter:CGPointMake(imgW - radius.downRight, imgH - radius.downRight) radius:radius.downRight startAngle:0 endAngle:M_PI_2 clockwise:YES];
    [path closePath];
    [path addClip];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = path.CGPath;
    
    return maskLayer;
}


/// 创建在 addView 上添加子view 平均间距的参照点view
/// - Parameters:
///   - addView: 所需要添加的视图 view，一般意义上的 super view
///   - itemWidth: 子 view 的宽度
///   - rowCount: 水平宽度上的子 view 个数
+ (NSArray<UIView *> * _Nonnull)makeReferViewWithAddView:(UIView *)addView itemWidth:(CGFloat)itemWidth rowCount:(NSInteger)rowCount {
    NSMutableArray<UIView *> *referViews = [NSMutableArray arrayWithCapacity:rowCount];
    UIView *lastReferV = nil;
    UIView *lastSpaceV = nil;
    for (int i = 0; i < rowCount; i++) {
        UIView *referV = [UIView new];
        [addView addSubview:referV];
        
        UIView *spaceV = lastReferV ? [UIView new] : nil;
        if (spaceV) {
            [addView addSubview:spaceV];
            [spaceV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(lastReferV.mas_right);
                if (lastSpaceV) {
                    make.width.equalTo(lastSpaceV);
                }
            }];
            lastSpaceV = spaceV;
        }
        
        [referV mas_makeConstraints:^(MASConstraintMaker *make) {
            if (spaceV) {
                make.left.equalTo(spaceV.mas_right);
            } else {
                make.left.mas_equalTo(0);
            }
            make.width.mas_equalTo(itemWidth);
        }];
        lastReferV = referV;
        [referViews addObject:referV];
    }
    [lastReferV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
    }];
    return referViews;
}

@end
