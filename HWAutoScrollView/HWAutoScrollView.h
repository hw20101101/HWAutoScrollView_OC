//
//  HWAutoScrollView.h
//  AutoScroll 
//
//  Created by hw on 16/9/19.
//  Copyright © 2016年 hwacdx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HWPageControlPosition) {
    HWPageControlPositionCenter,//底部中间
    HWPageControlPositionRight,//右下角
    HWPageControlPositionLeft//左下角
};

@interface HWAutoScrollView : UIView

/**
 * 图片点击事件
 * imageIndex:图片索引
 */
@property (nonatomic, copy) void (^imageOnClickCallBack) (NSInteger imageIndex);

/**
 * 分页控制器的位置
 */
@property (nonatomic, assign) HWPageControlPosition pageControlPosition;

/**
 * 图片的显示模式
 */
@property (nonatomic, assign) UIViewContentMode imageViewContentMode;

/**
 * 初始化广告轮播视图
 * @param imageNameArray 图片名称数组
 */
- (instancetype)initWithImageNameArray:(NSArray *)imageNameArray imageOnClickCallBack:(void (^)())imageOnClickCallBack;

/**
 * 初始化广告轮播视图
 * @param imageUrlArray 图片链接数组
 * @param placeHolder 占位图片
 */
- (instancetype)initWithImageUrlArray:(NSArray *)imageUrlArray placeHolder:(NSString *)placeHolder imageOnClickCallBack:(void (^)())imageOnClickCallBack;

@end
