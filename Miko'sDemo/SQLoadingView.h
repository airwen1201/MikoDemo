//
//  SQLoadingView.h
//  Miko'sDemo
//
//  Created by admin1 on 2017/8/10.
//  Copyright © 2017年 shiqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SQLoadingView : UIView
+ (void)presentInWindowWithText:(NSString *)text;

+ (void)presentInView:(UIView *)container withText:(NSString *)text;

+ (void)dismiss;
@end
