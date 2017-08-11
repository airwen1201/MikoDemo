//
//  SQApi.h
//  Miko'sDemo
//
//  Created by admin1 on 2017/8/10.
//  Copyright © 2017年 shiqi. All rights reserved.
//

#ifndef SQApi_h
#define SQApi_h

#ifdef LOCAL

#define SQ_SERVER_IP                (@"localhost") //
#define SQ_PORT                     (@"8080")

#else

#define SQ_SERVER_IP                (@"192.168.0.41")
#define SQ_PORT                     (@"14104")

#endif

//是否强制采用HTTPS链接
#define SQ_BASE_URL                 ([NSString stringWithFormat:@"http://%@:%@", SQ_SERVER_IP, SQ_PORT])

//API访问地址包装器
#define SQ_HTTP_URL(action)           ([NSString stringWithFormat:@"%@/%@", SQ_BASE_URL, action])



#endif /* SQApi_h */
