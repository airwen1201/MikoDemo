//
//  UINavigationController+EX.m
//  Miko'sDemo
//
//  Created by admin1 on 2017/8/11.
//  Copyright © 2017年 shiqi. All rights reserved.
//

#import "UINavigationController+EX.h"

static NvBarButtonDidBack nvBarButtonDidback;

@implementation UINavigationController (EX)

- (void)rightBarButtonWithTarget:(UINavigationController*)target withTitle:(NSString*)title AndBack:(NvBarButtonDidBack)back{
    nvBarButtonDidback = back;
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    target.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
}

- (void)back{
    nvBarButtonDidback();
}

@end
