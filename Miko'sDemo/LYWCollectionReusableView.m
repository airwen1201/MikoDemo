//
//  LYWCollectionReusableView.m
//  Miko'sDemo
//
//  Created by admin1 on 2017/7/6.
//  Copyright © 2017年 shiqi. All rights reserved.
//

#import "LYWCollectionReusableView.h"

@implementation LYWCollectionReusableView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        _dateLable = [[UILabel alloc] initWithFrame:self.bounds];
        [_dateLable setTextAlignment:NSTextAlignmentLeft];
        [_dateLable setFont:[UIFont systemFontOfSize:20]];
        _dateLable.textColor = [UIColor blackColor];
        [self addSubview:_dateLable];
    }
    return self;
}
@end
