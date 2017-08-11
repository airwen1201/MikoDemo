//
//  SQServiceUtil.m
//  Miko'sDemo
//
//  Created by admin1 on 2017/8/10.
//  Copyright © 2017年 shiqi. All rights reserved.
//

#import "SQServiceUtil.h"

NSString* const SQServiceErrorDomain = @"SQServiceErrorDomain";

@implementation SQServiceUtil

+ (NSError*)parseJsonResponse:(NSDictionary*)responseDict
{
    
    NSError* error = nil;
    NSNumber * success = responseDict[@"error_code"];
    BOOL succeeded = success.integerValue == 0;
    if (!succeeded) {
        NSString* code;
        if (responseDict[@"reason"]) {
            code = responseDict[@"reason"];
        }else{
            code = @"";
        }
        error = [NSError errorWithDomain:SQServiceErrorDomain code:1 userInfo:@{ NSLocalizedDescriptionKey : code }];
    }
    
    
    return error;
}

+ (AFHTTPRequestOperationManager*)AFNetworkingObjWithType:(BOOL)isJson
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 15;
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    manager.securityPolicy = securityPolicy;
    //申明返回的结果是json类型
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    if (isJson) {
        //申明请求的数据是json类型
        //AFNetwoking的默认Content-Type是application/x-www-form-urlencodem
        manager.requestSerializer=[AFJSONRequestSerializer serializer];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    }
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",@"text/plain", nil];
    //https用下面两句句
    //是否允许CA不信任的证书通过
    //    securityPolicy.allowInvalidCertificates = YES;
    //    //是否验证主机名
    //    securityPolicy.validatesDomainName = NO;
    return manager;
}

+ (void)AFNetworkingWithURL:(NSString*)urlStr andJsonType:(BOOL)isJson andParam:(NSDictionary*)dict andFinished:(AFDownloadFinish)FinishBlock{
    AFDownloadFinish fb = FinishBlock;
    AFHTTPRequestOperationManager *manager = [SQServiceUtil AFNetworkingObjWithType:isJson];
    
    [manager POST:urlStr parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError * error = [SQServiceUtil parseJsonResponse:responseObject];
        //dict = [responseObject objectForKey:@"list"];
        if (error == nil) {
            fb(nil,responseObject);
        }
        else
        {
            fb(error,responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        fb(error,nil);
    }];
}

+ (void)AFNetworkingWithURL:(NSString*)urlStr andParam:(NSDictionary*)dict andFinished:(AFDownloadFinish)FinishBlock{
    AFDownloadFinish fb = FinishBlock;
    AFHTTPRequestOperationManager *manager = [SQServiceUtil AFNetworkingObjWithType:NO];
    [manager GET:urlStr parameters:dict success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        NSError * error = [SQServiceUtil parseJsonResponse:responseObject];
        if (error == nil) {
            fb(nil,responseObject);
        }
        else
        {
            fb(error,responseObject);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        NSLog(@"Error: %@", error);
        fb(error,nil);
    }];
}

@end
