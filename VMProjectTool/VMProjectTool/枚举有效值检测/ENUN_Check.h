//
//  ENUN_Check.h
//  VMProjectTool
//
//  Created by yech on 2024/6/5.
//

#ifndef ENUN_Check_h
#define ENUN_Check_h

typedef NS_ENUM(NSUInteger, vMWDetailCardsType) {
    vMWDetailCardsTypeBanner = 0,
    vMWDetailCardsTypeApp = 1,
    vMWDetailCardsTypeData = 2,
    vMWDetailCardsTypeSetting = 3,
    vMWDetailCardsTypeLink = 4,
    vMWDetailCardsTypeAnnouncement = 5
};

// 检测枚举值是否在已经定义的范围内
#define NS_ENUM_CHECK(_type, _name) (((_name) >= (_type##First)) && ((_name) <= (_type##Last)))
// 避免低版本拿到高版本卡片数据时出现异常
#define vMWDetailCardsTypeFirst vMWDetailCardsTypeBanner
#define vMWDetailCardsTypeLast vMWDetailCardsTypeAnnouncement


#endif /* ENUN_Check_h */
