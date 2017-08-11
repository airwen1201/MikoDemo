//
//  JokeModel.h
//  Miko'sDemo
//
//  Created by admin1 on 2017/8/10.
//  Copyright © 2017年 shiqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JokeModel : NSObject

@property(nonatomic,strong) NSString *unixtime;

@property(nonatomic,strong) NSString *updatetime;

@property(nonatomic,strong) NSString *content;

@property(nonatomic,strong) NSString *hashId;

@end

@interface JokeViewModel : NSObject

@property(nonatomic,strong) JokeModel *jokeModel;

@property(nonatomic,assign) CGFloat height;

@end
