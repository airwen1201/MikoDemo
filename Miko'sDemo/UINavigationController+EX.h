//
//  UINavigationController+EX.h
//  Miko'sDemo
//
//  Created by admin1 on 2017/8/11.
//  Copyright © 2017年 shiqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (EX)
typedef void(^NvBarButtonDidBack)();
- (void)rightBarButtonWithTarget:(id)target withTitle:(NSString*)title AndBack:(NvBarButtonDidBack)back;
@end
