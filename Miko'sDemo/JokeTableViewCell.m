//
//  JokeTableViewCell.m
//  Miko'sDemo
//
//  Created by admin1 on 2017/8/10.
//  Copyright © 2017年 shiqi. All rights reserved.
//

#import "JokeTableViewCell.h"
#import "JokeModel.h"

@interface JokeTableViewCell()

//@property(nonatomic,strong)UILabel *contentLabel;

@end

@implementation JokeTableViewCell

//-(UILabel *)contentLabel
//{
//    if (_contentLabel == nil) {
//        _contentLabel = [[UILabel alloc] init];
//        [self.contentView addSubview:_contentLabel];
//    }
//    return _contentLabel;
//}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
