//
//  NSDate+EX.h
//  Miko'sDemo
//
//  Created by admin1 on 2017/7/6.
//  Copyright © 2017年 shiqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (EX)
#pragma mark - 获取日
- (NSInteger)day:(NSDate *)date;
#pragma mark - 获取月
- (NSInteger)month:(NSDate *)date;
#pragma mark - 获取年
- (NSInteger)year:(NSDate *)date;
#pragma mark - 获取当月第一天周几
- (NSInteger)firstWeekdayInThisMonth:(NSDate *)date;
#pragma mark - 获取当前月有多少天
- (NSInteger)totaldaysInMonth:(NSDate *)date;
@end
