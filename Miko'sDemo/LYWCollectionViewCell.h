//
//  LYWCollectionViewCell.h
//  Miko'sDemo
//
//  Created by admin1 on 2017/7/6.
//  Copyright © 2017年 shiqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LYWCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong) UILabel *dateLable;
@property (nonatomic,assign) BOOL isSelect;
- (instancetype)initWithFrame:(CGRect)frame;
@end
