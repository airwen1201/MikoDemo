//
//  JokeModel.m
//  Miko'sDemo
//
//  Created by admin1 on 2017/8/10.
//  Copyright © 2017年 shiqi. All rights reserved.
//

#import "JokeModel.h"

@implementation JokeModel



@end

@implementation JokeViewModel

-(void)setJokeModel:(JokeModel *)jokeModel
{
    _jokeModel = jokeModel;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth-40, 0)];
    label.numberOfLines = 0;
    label.text = _jokeModel.content;
    label.font = [UIFont systemFontOfSize:14];
    [label sizeToFit];
    _height = label.frame.size.height;
}

@end
