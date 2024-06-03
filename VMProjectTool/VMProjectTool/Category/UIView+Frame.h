//
//  UIView+Frame.h
//  
//
//  Created by apple on 15-3-5.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

struct YXRadius {
    CGFloat upLeft;     //The radius of upLeft.     左上半径
    CGFloat upRight;    //The radius of upRight.    右上半径
    CGFloat downLeft;   //The radius of downLeft.   左下半径
    CGFloat downRight;  //The radius of downRight.  右下半径
};
typedef struct YXRadius YXRadius;

static YXRadius const YXRadiusZero = (YXRadius){0, 0, 0, 0};

NS_INLINE YXRadius YXRadiusMake(CGFloat upLeft, CGFloat upRight, CGFloat downLeft, CGFloat downRight) {
    YXRadius radius;
    radius.upLeft = upLeft;
    radius.upRight = upRight;
    radius.downLeft = downLeft;
    radius.downRight = downRight;
    return radius;
}

@interface UIView (Frame)
// 分类不能添加成员属性
// @property如果在分类里面，只会自动生成get,set方法的声明，不会生成成员属性，和方法的实现
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;

@property (nonatomic, assign) CGPoint origin;

- (void)rounderWithCorners:(UIRectCorner)corners radius:(CGFloat)radius lineWidth:(CGFloat)lineWidth lineColor:(UIColor *_Nullable )lineColor;

/// 切部分边圆角
- (void)cornerRadiusByRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii;

/// 获取当前 view 在 toView 中的绝对位置
- (CGRect)localToView:(nonnull UIView *)toView;

/// 添加等宽子视图，视图间是否有间距
/// - Parameters:
///   - subViews: 需要添加的 views
///   - hasSpace: 视图间是否有间距
- (void)addEqualWidthSubViews:(NSArray<UIView *> * _Nonnull)subViews hasSpace:(BOOL)hasSpace;

/// 任意圆角
- (void)cornerRadiusWithRadius:(YXRadius)radius;
- (CAShapeLayer *)cornerRadiusShapeLayerWithRadius:(YXRadius)radius;



/// 创建在 addView 上添加子view 平均间距的参照点view
/// - Parameters:
///   - addView: 所需要添加的视图 view，一般意义上的 super view
///   - itemWidth: 子 view 的宽度
///   - rowCount: 水平宽度上的子 view 个数
+ (NSArray<UIView *> * _Nonnull)makeReferViewWithAddView:(UIView *)addView itemWidth:(CGFloat)itemWidth rowCount:(NSInteger)rowCount;

@end
