//
//  SQTools.h
//  Miko'sDemo
//
//  Created by admin1 on 2017/7/10.
//  Copyright © 2017年 shiqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQTools : NSObject

+ (NSInteger) calcDaysFromBegin:(NSDate *)beginDate end:(NSDate *)endDate;

+ (NSDate*)dateWithYear:(NSString*)year withMonth:(NSString*)month withDay:(NSString*)day;

//计算miko是否是工作日
+ (BOOL)mikoIsWorkday:(NSDate*)date andToday:(NSDate*)today;

+(NSDate *)stringDateToDate:(NSString *)date;

+ (NSString*)dateToString:(NSDate*)date;
@end
