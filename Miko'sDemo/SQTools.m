//
//  SQTools.m
//  Miko'sDemo
//
//  Created by admin1 on 2017/7/10.
//  Copyright © 2017年 shiqi. All rights reserved.
//

#import "SQTools.h"

@implementation SQTools

//计算两个日期之间的天数
+ (NSInteger) calcDaysFromBegin:(NSDate *)beginDate end:(NSDate *)endDate
{
    //创建日期格式化对象
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    //取两个日期对象的时间间隔：
    //这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:typedef double NSTimeInterval;
    NSTimeInterval time=[endDate timeIntervalSinceDate:beginDate];
    
    int days=((int)time)/(3600*24);
    //int hours=((int)time)%(3600*24)/3600;
    //NSString *dateContent=[[NSString alloc] initWithFormat:@"%i天%i小时",days,hours];
    return days;
}


+ (NSDate*)dateWithYear:(NSString*)year withMonth:(NSString*)month withDay:(NSString*)day
{
    NSString *dateStr = [NSString stringWithFormat:@"%@-%@-%@ 10:00:00",year,month,day];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //  [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSTimeZone* sourceTimeZone = [NSTimeZone systemTimeZone];
    
    formatter.timeZone = sourceTimeZone;
    
    NSDate *date = [formatter dateFromString:dateStr];
    return date;
}


+ (BOOL)mikoIsWorkday:(NSDate*)date andToday:(NSDate*)today
{
    NSInteger i = [SQTools calcDaysFromBegin:date end:today];
    NSInteger j = i%8;
    if(i == 165)
    {
        NSLog(@"123");
    }
    if (j == 0 || j == 1 || j ==2 || j ==-6 || j ==-7) {
        return YES;
    }else{
        return NO;
    }
    
}


+(NSDate *)stringDateToDate:(NSString *)date{
    
    NSDate *resultDate;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSTimeZone* sourceTimeZone = [NSTimeZone systemTimeZone];
    
    formatter.timeZone = sourceTimeZone;
    
    resultDate = [formatter dateFromString:[NSString stringWithFormat:@"%@",date]];
    
    return resultDate;
}


+ (NSString*)dateToString:(NSDate*)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
    return strDate;
}

@end
