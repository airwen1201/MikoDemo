//
//  NSString+EX.m
//  Miko'sDemo
//
//  Created by admin1 on 2017/8/12.
//  Copyright © 2017年 shiqi. All rights reserved.
//

#import "NSString+EX.h"

@implementation NSString (EX)

- (NSString *)trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

+ (BOOL)isEmpty:(NSString *)string {
    if (string == nil || [string isKindOfClass:[NSNull class]] || ([string isKindOfClass:[NSString class]] && [string trim].length == 0)) {
        return YES;
    }
    return NO;
}



@end
