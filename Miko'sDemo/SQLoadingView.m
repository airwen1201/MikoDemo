//
//  SQLoadingView.m
//  Miko'sDemo
//
//  Created by admin1 on 2017/8/10.
//  Copyright © 2017年 shiqi. All rights reserved.
//

#import "SQLoadingView.h"

@implementation SQLoadingView{
    UIActivityIndicatorView *   indicator;
    UIView *                    backgroundView;//黑色圆角半透明背景
    UILabel *                   textLabel;
    UIView *                    maskView;//透明遮罩，防止用户点击
}
- (void)updateLayout {
    backgroundView.frame = CGRectMake((self.frame.size.width-200)/2,
                                      (self.frame.size.height-100)/2,
                                      200, 100);
    indicator.frame = CGRectMake((backgroundView.frame.size.width-37)/2,
                                 (backgroundView.frame.size.height-37)/2,
                                 37, 37);
    CGFloat y = backgroundView.frame.size.height - 20 - 8;
    CGFloat w = backgroundView.frame.size.width - 8*2;
    textLabel.frame = CGRectMake(8, y, w, 20);
    
    maskView.frame = self.bounds;
}

+ (instancetype)sharedInstance {
    static SQLoadingView * lv = nil;
    
    if (lv == nil) {
        lv = [[SQLoadingView alloc] initWithFrame:CGRectZero];
        
        lv.backgroundColor = [UIColor clearColor];
        lv->indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        
        lv->textLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        lv->textLabel.backgroundColor = [UIColor clearColor];
        lv->textLabel.font = [UIFont systemFontOfSize:14];
        lv->textLabel.textColor = [UIColor whiteColor];
        lv->textLabel.textAlignment = NSTextAlignmentCenter;
        
        lv->backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
        lv->backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7f];
        lv->backgroundView.layer.cornerRadius = 8.0f;
        lv->backgroundView.layer.masksToBounds = YES;
        [lv->backgroundView addSubview:lv->indicator];
        [lv->backgroundView addSubview:lv->textLabel];
        
        lv->maskView = [[UIView alloc] initWithFrame:CGRectZero];
        lv->maskView.userInteractionEnabled = YES;
        
        [lv addSubview:lv->maskView];
        [lv addSubview:lv->backgroundView];
    }
    
    return lv;
}

#pragma mark - Public

+ (void)presentInWindowWithText:(NSString *)text {
    UIWindow * win = [[UIApplication sharedApplication] keyWindow];
    [self presentInView:win withText:text];
}

+ (void)presentInView:(UIView *)container withText:(NSString *)text {
    dispatch_async(dispatch_get_main_queue(), ^{
        SQLoadingView * lv = [self sharedInstance];
        [container addSubview:lv];
        lv.frame = container.bounds;
        lv->textLabel.text = text;
        [lv updateLayout];
        [lv->indicator startAnimating];
    });
}

+ (void)dismiss {
    dispatch_async(dispatch_get_main_queue(), ^{
        SQLoadingView * lv = [self sharedInstance];
        [lv->indicator stopAnimating];
        [lv removeFromSuperview];
    });
}

@end
