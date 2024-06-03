//
//  UIImage+Extension.m
//  JYJ微博
//
//  Created by JYJ on 15/3/11.
//  Copyright (c) 2015年 JYJ. All rights reserved.
//

#import "UIImage+Extension.h"
#import <objc/message.h>
#import "UIImage+GIF.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import "YXThreadLockManager.h"
#import <GPUImage/GPUImage.h>

@implementation UIImage (Extension)
/**
 *  带边框的图片(方形)
 *
 *  @param insets 边框与原图的间距
 *  @param color  边框颜色
 *
 *  @return UIImage
 */
- (UIImage *)imageByInsetEdge:(UIEdgeInsets)insets withColor:(UIColor *)color{
    CGSize size = self.size;
    size.width -= insets.left + insets.right;
    size.height -= insets.top + insets.bottom;
    if (size.width <= 0 || size.height <= 0) {
        return nil;
    }
    CGRect rect = CGRectMake(-insets.left, -insets.top, self.size.width, self.size.height);
    UIGraphicsBeginImageContextWithOptions(size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (color) {
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddRect(path, NULL, CGRectMake(0, 0, size.width, size.height));
        CGPathAddRect(path, NULL, rect);
        CGContextAddPath(context, path);
        CGContextEOFillPath(context);
        CGPathRelease(path);
    }
    [self drawInRect:rect];
    UIImage *insetEdgedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return insetEdgedImage;
}

+ (UIImage *)createImageWithColor:(UIColor *)color size:(CGSize)size radius:(CGFloat)radius {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius];
    CGContextAddPath(context, path.CGPath);
    CGContextFillPath(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)resizedImage:(NSString *)name {
    UIImage *image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}

+ (UIImage *)createImageWithColor:(UIColor*) color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

/**
 *  带边框的图片
 *
 *  @param image        图片
 *  @param borderWidth 边框宽度
 *  @param borderColor 边框颜色
 */
+ (instancetype)circleImageWithImage:(UIImage *)image borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    // 1.加载原图
    UIImage *oldImage = image;
    
    // 2.开启上下文
    CGFloat imageW = oldImage.size.width + 2 * borderWidth;
    CGFloat imageH = oldImage.size.height + 2 * borderWidth;
    CGSize imageSize = CGSizeMake(imageW, imageH);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    // 3.取得当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 4.画边框(大圆)
    [borderColor set];
    CGFloat bigRadius = imageW * 0.5; // 大圆半径
    CGFloat centerX = bigRadius; // 圆心
    CGFloat centerY = bigRadius;
    CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx); // 画圆
    
    // 5.小圆
    CGFloat smallRadius = bigRadius - borderWidth;
    CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    // 裁剪(后面画的东西才会受裁剪的影响)
    CGContextClip(ctx);
    
    // 6.画图
    [oldImage drawInRect:CGRectMake(borderWidth, borderWidth, oldImage.size.width, oldImage.size.height)];
    
    // 7.取图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 8.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

+ (instancetype)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    // 1.加载原图
    UIImage *oldImage = [UIImage imageNamed:name];
    
    // 2.开启上下文
    CGFloat imageW = oldImage.size.width + 2 * borderWidth;
    CGFloat imageH = oldImage.size.height + 2 * borderWidth;
    CGSize imageSize = CGSizeMake(imageW, imageH);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    // 3.取得当前的上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 4.画边框(大圆)
    [borderColor set];
    CGFloat bigRadius = imageW * 0.5; // 大圆半径
    CGFloat centerX = bigRadius; // 圆心
    CGFloat centerY = bigRadius;
    CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx); // 画圆
    
    // 5.小圆
    CGFloat smallRadius = bigRadius - borderWidth;
    CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    // 裁剪(后面画的东西才会受裁剪的影响)
    CGContextClip(ctx);
    
    // 6.画图
    [oldImage drawInRect:CGRectMake(borderWidth, borderWidth, oldImage.size.width, oldImage.size.height)];
    
    // 7.取图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 8.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

//图片矫正方向
+ (UIImage *)fixOrientation:(UIImage *)aImage {
    
    
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }
    
    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

//压缩图片
+(NSData *)resetSizeOfImageDataWithmaxSize:(NSInteger)maxSize data:(NSData *)data{
    UIImage *image = [UIImage imageWithData:data];
    NSData *returnData =  [image  resetSizeOfImageDataWithmaxSize:maxSize];
    return returnData;
}

#pragma mark - 图片压缩
- (NSData *)resetSizeOfImageDataWithmaxSize:(NSInteger)maxSize {
    
    UIImage *sourceImage = self;
    //先判断当前质量是否满足要求，不满足再进行压缩
    __block NSData *finallImageData = UIImageJPEGRepresentation(sourceImage,1.0);
    NSUInteger sizeOrigin = finallImageData.length;
    NSUInteger sizeOriginKB = sizeOrigin / 1000;
    if (sizeOriginKB <= maxSize){
        return finallImageData;
    }
    
    //获取原图片宽高比
    float sourceImageAspectRatio = sourceImage.size.width/sourceImage.size.height;
    //先调整分辨率
    CGSize defaultSize = CGSizeMake(1024, 1024/sourceImageAspectRatio);
    UIImage *newImage = [self newSizeImage:defaultSize image:sourceImage];
    finallImageData = UIImageJPEGRepresentation(newImage,1.0);
    //保存压缩系数
    NSMutableArray *compressionQualityArr = [NSMutableArray array];
    CGFloat avg = 1.0/250;
    CGFloat value = avg;
    for (int i = 250; i >= 1; i--) {
        value = i*avg;
        [compressionQualityArr addObject:@(value)];
    }
    /* 调整大小 说明：压缩系数数组compressionQualityArr是从大到小存储。 */ //思路：使用二分法搜索
    finallImageData = [self halfFuntion:compressionQualityArr image:newImage sourceData:finallImageData maxSize:maxSize];
    //如果还是未能压缩到指定大小，则进行降分辨率
    while (finallImageData.length == 0) {
        //每次降100分辨率
        CGFloat reduceWidth = 100.0;
        CGFloat reduceHeight = 100.0/sourceImageAspectRatio;
        if (defaultSize.width-reduceWidth <= 0 || defaultSize.height-reduceHeight <= 0) {
            break;
        }
        defaultSize = CGSizeMake(defaultSize.width-reduceWidth, defaultSize.height-reduceHeight);
        UIImage *image = [self newSizeImage:defaultSize image:[UIImage imageWithData:UIImageJPEGRepresentation(newImage,[[compressionQualityArr lastObject] floatValue])]];
        finallImageData = [self halfFuntion:compressionQualityArr image:image sourceData:UIImageJPEGRepresentation(image,1.0) maxSize:maxSize];
    }
    return finallImageData;
}

#pragma mark 调整图片分辨率/尺寸（等比例缩放）
- (UIImage *)newSizeImage:(CGSize)size image:(UIImage *)sourceImage {
    CGSize newSize = CGSizeMake(sourceImage.size.width, sourceImage.size.height);
    CGFloat tempHeight = newSize.height / size.height;
    CGFloat tempWidth = newSize.width / size.width;
    if (tempWidth > 1.0 && tempWidth > tempHeight) {
        newSize = CGSizeMake(sourceImage.size.width / tempWidth, sourceImage.size.height / tempWidth);
    } else if (tempHeight > 1.0 && tempWidth < tempHeight) {
        newSize = CGSizeMake(sourceImage.size.width / tempHeight, sourceImage.size.height / tempHeight);
    }
    
    UIGraphicsBeginImageContext(newSize);
    [sourceImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark 二分法
- (NSData *)halfFuntion:(NSArray *)arr image:(UIImage *)image sourceData:(NSData *)finallImageData maxSize:(NSInteger)maxSize {
    NSData *tempData = [NSData data];
    NSUInteger start = 0;
    NSUInteger end = arr.count - 1;
    NSUInteger index = 0;
    
    NSUInteger difference = NSIntegerMax;
    while(start <= end) {
        index = start + (end - start)/2;
        finallImageData = UIImageJPEGRepresentation(image,[arr[index] floatValue]);
        NSUInteger sizeOrigin = finallImageData.length;
        NSUInteger sizeOriginKB = sizeOrigin / 1024;
        //NSLog(@"当前降到的质量：%ld", (unsigned long)sizeOriginKB);
        //NSLog(@"\nstart：%zd\nend：%zd\nindex：%zd\n压缩系数：%lf", start, end, (unsigned long)index, [arr[index] floatValue]);
        if (sizeOriginKB > maxSize) {
            start = index + 1;
        } else if (sizeOriginKB < maxSize) {
            if (maxSize-sizeOriginKB < difference) {
                difference = maxSize-sizeOriginKB;
                tempData = finallImageData;
            }
            if (index<=0) {
                break;
            }
            end = index - 1;
        } else {
            break;
        }
    }
    return tempData;
}


#pragma mark 压缩GIF图片
+ (NSData*)cropGifExpressionWithImageData:(NSData*)imageData {
    CGRect toRect = CGRectMake(0, 0, 400, 400);
    
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)imageData, NULL);
    CGImageRef imageRef = CGImageSourceCreateImageAtIndex(source, 0, NULL);
    UIImage* firstImage = [UIImage imageWithCGImage:imageRef];
    
    BOOL isCrop = NO;
    if (firstImage.size.width > 400 || firstImage.size.height > 400) {
        isCrop = YES;
    }
    
    if (!isCrop) {
        return imageData;
    }
    
    //gif播放速率
    UIImage *gifImage = [UIImage sd_imageWithGIFData:imageData];
    NSUInteger countd = gifImage.images.count;
    NSTimeInterval duration = gifImage.duration;
    NSTimeInterval delay = duration / (NSTimeInterval)countd;
    if (delay < 0.02) delay = 0.1;
    
    //获取 GIF 帧的个数
    size_t count = CGImageSourceGetCount(source);
    //获取帧集合并裁剪
    UIImage *animatedImage = nil;
    NSMutableArray *images = [NSMutableArray array];
    
    for (size_t i = 0; i < count; i++) {
        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(source, i, NULL);
        //将图片源转换成UIimageView能使用的图片源
        UIImage* image = [UIImage imageWithCGImage:imageRef];
        //裁剪图片
        UIImage *cropImage = [image newSizeImage:toRect.size image:image];
        
        [images addObject:cropImage];
        CGImageRelease(imageRef);
    }
    //生产GIF图片
    animatedImage = [UIImage animatedImageWithImages:images duration:duration];
    
    
    CFRelease(source);
    
    NSURL *url = [self __cacheURL:@"gif"];
    NSData *gifData = [self getGIFDataWithGifImage:animatedImage images:images cacheURL:url];
    
    
    return gifData;
}



#pragma mark 动图UIImage转成NSData
+ (NSData*)getGIFDataWithGifImage:(UIImage*)gifImage images:(NSArray<UIImage *> *)images cacheURL:(NSURL *)cacheURL {
    NSMutableArray *delays = [NSMutableArray array];
    NSUInteger countd = images.count;
    NSTimeInterval duration = gifImage.duration;
    NSTimeInterval delay = duration / (NSTimeInterval)countd;
    if (delay < 0.02) delay = 0.1;
    [delays addObject:@(delay)];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:cacheURL.path]) {
        [fileManager removeItemAtURL:cacheURL error:nil];
    }
    
    size_t count = images.count;
    CGImageDestinationRef destination = CGImageDestinationCreateWithURL((__bridge CFURLRef)cacheURL, kUTTypeGIF, count, NULL);
    if (destination == NULL) return nil;
    
    NSDictionary *gifProperty =
    @{
        (__bridge id)kCGImagePropertyGIFDictionary:
            @{(__bridge id)kCGImagePropertyGIFHasGlobalColorMap: @YES,
              (__bridge id)kCGImagePropertyColorModel: (NSString *)kCGImagePropertyColorModelRGB,
              (__bridge id)kCGImagePropertyDepth: @8,
              (__bridge id)kCGImagePropertyGIFLoopCount: @0}
    };
    CGImageDestinationSetProperties(destination, (CFDictionaryRef)gifProperty);
    
    void (^cacheBlock)(NSInteger i);
    if (images.count == delays.count) {
        cacheBlock = ^(NSInteger i) {
            UIImage *img = images[i];
            NSTimeInterval delay = [delays[i] doubleValue];
            NSDictionary *frameProperty = @{(NSString *)kCGImagePropertyGIFDictionary: @{(NSString *)kCGImagePropertyGIFDelayTime: @(delay)}};
            CGImageDestinationAddImage(destination, img.CGImage, (CFDictionaryRef)frameProperty);
        };
    } else {
        NSTimeInterval delay = delays.count ? [delays.firstObject doubleValue] : 0.1;
        NSDictionary *frameProperty = @{(NSString *)kCGImagePropertyGIFDictionary: @{(NSString *)kCGImagePropertyGIFDelayTime: @(delay)}};
        
        cacheBlock = ^(NSInteger i) {
            UIImage *img = images[i];
            CGImageDestinationAddImage(destination, img.CGImage, (CFDictionaryRef)frameProperty);
        };
    }
    
    for (NSInteger i = 0; i < count; i++) {
        cacheBlock(i);
    }
    
    BOOL isCacheSuccess = CGImageDestinationFinalize(destination);
    CFRelease(destination);
    //    if (!isCacheSuccess) [fileManager removeItemAtURL:cacheURL error:nil];
    
    NSData *gifData = [NSData dataWithContentsOfURL:cacheURL];
    
    return gifData;
}


+ (NSURL *)__cacheURL:(NSString *)extension {
    NSString *folderPath = NSTemporaryDirectory();
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDirectoryEnumerator *fileEnumerator = [fileManager enumeratorAtPath:folderPath];
    for (NSString *fileName in fileEnumerator) {
        [fileManager removeItemAtPath:[folderPath stringByAppendingPathComponent:fileName] error:nil];
    }
    
    NSString *fileName = [NSString stringWithFormat:@"%.0lf.%@", [[NSDate date] timeIntervalSince1970], extension];
    NSString *cachePath = [folderPath stringByAppendingPathComponent:fileName];
    return [NSURL fileURLWithPath:cachePath];
}

#pragma mark 获取图片缩略图
+ (NSData *)getThumbnailImageWithImage:(UIImage *)image
{
    
    UIImage *thumbnailImage = [self getThumbnailImageWithImage:image maxlength:200];
    
    NSData *thumbnailData = UIImageJPEGRepresentation(thumbnailImage, 0.8);
    if (thumbnailData.length > 20*1024) {
        thumbnailData = UIImageJPEGRepresentation(thumbnailImage, 0.5);
        
        if (thumbnailData.length > 20*1024) {
            thumbnailData = UIImageJPEGRepresentation(thumbnailImage, 0.5);
            
            if (thumbnailData.length > 20*1024) {
                thumbnailImage = [self getThumbnailImageWithImage:image maxlength:100];
                thumbnailData = UIImageJPEGRepresentation(thumbnailImage, 0.5);
                return thumbnailData;
            }else {
                return thumbnailData;
            }
        } else {
            return thumbnailData;
        }
    } else {
        return thumbnailData;
    }
    
}

#pragma mark 压缩图片体积，指定最大边
+ (UIImage *)getThumbnailImageWithImage:(UIImage *)image maxlength:(CGFloat)maxlength
{
    UIImage *thumbnailImage;
    
    CGSize sourceSize = image.size;
    if (!(sourceSize.width > maxlength || sourceSize.height > maxlength))return image;
    
    CGSize targetSize;
    if (sourceSize.width >= sourceSize.height) {
        CGFloat height =  (maxlength*sourceSize.height) / sourceSize.width;
        targetSize = CGSizeMake(maxlength, height);
    } else {
        CGFloat width =  (maxlength*sourceSize.width) / sourceSize.height;
        targetSize = CGSizeMake(width, maxlength);
    }
    
    thumbnailImage = [UIImage imageWithImage:image scaledToSize:CGSizeMake(targetSize.width, targetSize.height)];
    
    return thumbnailImage;
}

#pragma mark 绘制图片尺寸
+ (UIImage *)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    NSInteger newWidth = (NSInteger)newSize.width;
    NSInteger newHeight = (NSInteger)newSize.height;
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
    
    
    [image drawInRect:CGRectMake(0 , 0,newWidth, newHeight)];
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark 通过图片Data数据第一个字节 来获取图片扩展名
+ (NSString *)contentTypeForImageData:(NSData *)data{
    uint8_t c;
    [data getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return @"jpeg";
        case 0x89:
            return @"png";
        case 0x47:
            return @"gif";
        case 0x49:
        case 0x4D:
            return @"tiff";
        case 0x52:
            if ([data length] < 12) {
                return nil;
            }
            NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
            if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]) {
                return @"webp";
            }
            return nil;
    }
    return nil;
}

//图片处理成圆形
- (UIImage *)yx_circularImage {
    //1.开启跟原始图片一样大小的上下文
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    //2.设置一个圆形裁剪区域
    //2.1绘制一个圆形
    
    float widht = (self.size.width <= self.size.height)? self.size.width: self.size.height;
    float height = (self.size.height <= self.size.width)? self.size.height: self.size.width;
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake((self.size.width - widht)/2.0, (self.size.height - height)/2.0, widht, height)];
    //2.2.把圆形的路径设置成裁剪区域
    [path addClip];//超过裁剪区域以外的内容都给裁剪掉
    //3.把图片绘制到上下文当中(超过裁剪区域以外的内容都给裁剪掉)
    [self drawAtPoint:CGPointZero];
    //4.从上下文当中取出图片
    UIImage *newImage =  UIGraphicsGetImageFromCurrentImageContext();
    //5.关闭上下文
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark 获取二维码的内容，系统方法
+ (NSString *)getQrcoudeContentWithCodeImage:(UIImage *)codeImage {
    CIImage *ciImage = [[CIImage alloc] initWithCGImage:codeImage.CGImage options:nil];
    // 软件渲染
    CIContext *ciContext = [CIContext contextWithOptions:@{kCIContextUseSoftwareRenderer : @(YES)}];
    // 二维码识别
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:ciContext options:@{CIDetectorAccuracy : CIDetectorAccuracyHigh}];
    NSArray *features = [detector featuresInImage:ciImage];
    if (features.count) {
        NSString *qrCodeUrl = nil;
        for (CIQRCodeFeature *feature in features) {
            qrCodeUrl = feature.messageString;
        }
        return qrCodeUrl;
    } else {
    }
    return nil;
}


/// 项目 vip 图标
+ (instancetype)makeVipIcon:(VipLevelType)type {
    NSString *name = [self getVipIconNameWithType:type];
    return [self imageNamed:name];
}

///  根据类型获取对应图片名
+ (NSString *)getVipIconNameWithType:(VipLevelType)type {
    switch (type) {
        case VipLevelTypeVipUnavailable:
            return @"ic_duihua_vip1";
        case VipLevelTypeVip:
            return @"ic_duihua_vip";
        case VipLevelTypeSvipUnavailable:
            return @"ic_duihua_svip1";
        case VipLevelTypeSvip:
            return @"ic_duihua_svip";
        case VipLevelTypeSvip1Unavailable:
            return @"ic_duihua_svip1_gray";
        case VipLevelTypeSvip1:
            return @"ic_duihua_svip_neo_1";
        case VipLevelTypeSvip2:
            return @"ic_duihua_svip_neo_2";
        case VipLevelTypeSvip3:
            return @"ic_duihua_svip_neo_3";
        case VipLevelTypeSvip4:
            return @"ic_duihua_svip_neo_4";
        case VipLevelTypeSvip5:
            return @"ic_duihua_svip_neo_5";
        case VipLevelTypeSvip6:
            return @"ic_duihua_svip_neo_6";
        case VipLevelTypeSvip7:
            return @"ic_duihua_svip_neo_7";
        case VipLevelTypeSvip8:
            return @"ic_duihua_svip_neo_8";
        case VipLevelTypeSvip9:
            return @"ic_duihua_svip_neo_9";
        case VipLevelTypeGoldUnavailable:
            return @"ic_duihua_huangjin1";
        case VipLevelTypeGold:
            return @"ic_duihua_huangjin";
        case VipLevelTypePlatinumUnavailable:
            return @"ic_duihua_bojin1";
        case VipLevelTypePlatinum:
            return @"ic_duihua_bojin";
        case VipLevelTypeDiamondUnavailable:
            return @"ic_duihua_zuanshi1";
        case VipLevelTypeDiamond:
            return @"ic_duihua_zuanshi";
        case VipLevelTypeGoldDiamondUnavailable:
            return @"ic_duihua_jinzuan1";
        case VipLevelTypeGoldDiamond:
            return @"ic_duihua_jinzuan";
        case VipLevelTypeBeautifyUnavailable:
            return @"ic_duihua_lianghao1";
        case VipLevelTypeUserBeautify:
            return @"ic_duihua_lianghao";
        case VipLevelTypeGroupBeautify:
            return @"ic_duihua_qunlainghao";
        case VipLevelTypeReal:
            return @"ic_renzheng";
        default:
            return @"";
    }
}

/// 返回一个经高斯模糊处理的新图
- (UIImage *)imageWithGaussianBlurFilterHandlePixel:(NSInteger)pixel {
    // 模糊处理
    GPUImageGaussianBlurFilter *gaussianBlurFilter = [[GPUImageGaussianBlurFilter alloc] init];
    gaussianBlurFilter.blurRadiusInPixels = pixel > 0 ? pixel : 2;
    [gaussianBlurFilter forceProcessingAtSize:self.size];
    [gaussianBlurFilter useNextFrameForImageCapture];
    
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:self];
    [stillImageSource addTarget:gaussianBlurFilter];
    [stillImageSource processImage];
    
    UIImage *blurImage = [gaussianBlurFilter imageFromCurrentFramebuffer];
    return blurImage;
}

/// 复制一个 view 中指定位置的 image
+ (UIImage *)screenWithView:(UIView *)view rect:(CGRect)rect {
    UIGraphicsImageRendererFormat *format = [[UIGraphicsImageRendererFormat alloc] init];
    format.scale = 0;
    format.opaque = NO;
    UIGraphicsImageRenderer *render = [[UIGraphicsImageRenderer alloc] initWithBounds:rect format:format];
    UIImage *imageOut = [render imageWithActions:^(UIGraphicsImageRendererContext * _Nonnull rendererContext) {
        CGContextRef context = rendererContext.CGContext;
        CGContextInspectContextReturnVoid(context);
        [view.layer renderInContext:context];
    }];
    return imageOut;
}

/// 复制一个 view 中指定位置的 image，可指定圆角
+ (UIImage *)screenWithView:(UIView *)view rect:(CGRect)rect radius:(CGFloat)radius {
    UIImage *image = [self screenWithView:view rect:rect];
    //1.开启图片图形上下文:注意设置透明度为非透明
    UIGraphicsBeginImageContextWithOptions(rect.size, YES, 0.0);
//    //2设置圆角后,填充背景色
//    [self.superview.backgroundColor setFill];
//    UIRectFill(rect);
    
    //3.绘制圆裁切路线
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:rect.size.height * 0.5];
    [path addClip];
    
    //4.绘制内切的圆形边框
    [[UIColor redColor] setStroke];
    [path stroke];
    
    //5.绘制图片
    [image drawInRect:rect];
    
    //6.获取图片
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    //7.关闭图形上下文
    UIGraphicsEndImageContext();
    
    return image;
}







/// 根据一个 image 创建一个指定位置的 image
+ (UIImage *)copyImage:(UIImage *)image withRect:(CGRect)rect {
    CGFloat x = rect.origin.x, y = rect.origin.y, w = rect.size.width, h = rect.size.height;
    CGImageRef imageRef = image.CGImage;
    CGImageRef rstImageRef = CGImageCreateWithImageInRect(imageRef, CGRectMake(x, y, w, h));
    UIImage *rstImage = [UIImage imageWithCGImage:rstImageRef scale:image.scale orientation:image.imageOrientation];
    CGImageRelease(rstImageRef);
    return rstImage;
}

@end
