//
//  SQAdvertisingScrollView.h
//  Miko'sDemo
//
//  Created by admin1 on 2017/8/12.
//  Copyright © 2017年 shiqi. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SQAdvertisingScrollView;

@protocol SQAdvertisingScrollViewDelegate <NSObject>

@optional
- (void)advertisingScrollView:(SQAdvertisingScrollView *)scrollView  clickEventAtIndex:(NSInteger)index;
@end

@interface SQAdvertisingScrollView : UIView

@property (strong, nonatomic) id <SQAdvertisingScrollViewDelegate> delegate;

/**
 图像占位符
 */
@property (strong, nonatomic) UIImage *placeholderImage;

/**
 使用本地图片初始化
 */
@property (strong, nonatomic) NSArray <UIImage *> *images;

/**
 使用本地图片的名称初始化
 */
@property (strong, nonatomic) NSArray <NSString *> *imageNames;

/**
 使用网络图片的URL地址初始化
 */
@property (strong, nonatomic) NSArray <NSString *> *imageUrls;

/**
 广告滚动视图是否自动滚动，默认为YES
 */
@property (assign, nonatomic) BOOL autoLoop;

/**
 广告滚动视图自动滚动的时间间隔
 */
@property (assign, nonatomic) NSTimeInterval autoLoopInterval;

@property(nonatomic,strong) NSArray *titleArray;
@end
