//
//  SQServiceUtil.h
//  Miko'sDemo
//
//  Created by admin1 on 2017/8/10.
//  Copyright © 2017年 shiqi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^AFDownloadFinish)(NSError*error,NSDictionary*dictionary);

@interface SQServiceUtil : NSObject
+ (void)AFNetworkingWithURL:(NSString*)urlStr andParam:(NSDictionary*)dict andFinished:(AFDownloadFinish)FinishBlock;
+ (void)AFNetworkingWithURL:(NSString*)urlStr andJsonType:(BOOL)isJson andParam:(NSDictionary*)dict andFinished:(AFDownloadFinish)FinishBlock;
@end
